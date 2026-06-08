param(
    [string]$Root,
    [switch]$Strict
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 2.0

function Resolve-AgentRoot {
    param([string]$RequestedRoot)

    if (-not [string]::IsNullOrWhiteSpace($RequestedRoot)) {
        return (Resolve-Path -LiteralPath $RequestedRoot).Path
    }

    $GitRoot = $null
    try {
        $GitOutput = & git rev-parse --show-toplevel 2>$null
        if ($LASTEXITCODE -eq 0 -and $GitOutput) {
            $GitRoot = @($GitOutput)[0]
        }
    } catch {
        $GitRoot = $null
    }

    if (-not [string]::IsNullOrWhiteSpace($GitRoot)) {
        return (Resolve-Path -LiteralPath $GitRoot).Path
    }

    if (-not [string]::IsNullOrWhiteSpace($PSScriptRoot)) {
        return (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path
    }

    return (Get-Location).Path
}

$RepoRoot = Resolve-AgentRoot -RequestedRoot $Root
$Results = New-Object System.Collections.Generic.List[object]

function Add-Result {
    param(
        [ValidateSet("PASS", "WARN", "FAIL")]
        [string]$Level,
        [string]$Message,
        [string]$Path = ""
    )

    $Results.Add([pscustomobject]@{
        Level = $Level
        Message = $Message
        Path = $Path
    }) | Out-Null
}

function Join-RepoPath {
    param([string]$RelativePath)
    return (Join-Path $RepoRoot $RelativePath)
}

function Test-RepoPath {
    param([string]$RelativePath)
    return (Test-Path -LiteralPath (Join-RepoPath $RelativePath))
}

function Read-RepoText {
    param([string]$RelativePath)
    return (Get-Content -Raw -LiteralPath (Join-RepoPath $RelativePath))
}

function Require-Path {
    param(
        [string]$RelativePath,
        [string]$Description
    )

    if (Test-RepoPath $RelativePath) {
        Add-Result "PASS" "$Description exists." $RelativePath
    } else {
        Add-Result "FAIL" "$Description is missing." $RelativePath
    }
}

function Normalize-AgentPath {
    param([string]$PathText)

    $Value = $PathText.Trim().Trim('`').Trim()
    return ($Value -replace '\\', '/')
}

function Get-MarkdownSection {
    param(
        [string]$Content,
        [string]$Heading
    )

    $EscapedHeading = [regex]::Escape($Heading)
    $Pattern = "(?ms)^##\s+$EscapedHeading\s*\r?\n(?<body>.*?)(?=^##\s+|\z)"
    $Match = [regex]::Match($Content, $Pattern)
    if ($Match.Success) {
        return $Match.Groups["body"].Value
    }
    return ""
}

function Require-Heading {
    param(
        [string]$Content,
        [string]$Heading,
        [string]$Path
    )

    $EscapedHeading = [regex]::Escape($Heading)
    if ($Content -match "(?m)^##\s+$EscapedHeading\s*$") {
        Add-Result "PASS" "Required heading '$Heading' is present." $Path
    } else {
        Add-Result "FAIL" "Required heading '$Heading' is missing." $Path
    }
}

function Get-ArtifactFiles {
    param([string]$RelativeDirectory)

    $Directory = Join-RepoPath $RelativeDirectory
    if (-not (Test-Path -LiteralPath $Directory)) {
        return @()
    }

    return @(Get-ChildItem -LiteralPath $Directory -File -Filter "*.md" |
        Where-Object { $_.Name -ne ".gitkeep" })
}

function Test-ArtifactHeadings {
    param(
        [System.IO.FileInfo[]]$Files,
        [string[]]$Headings
    )

    foreach ($File in $Files) {
        $RelativePath = ($File.FullName.Substring($RepoRoot.Length).TrimStart([char[]]@('\', '/')) -replace '\\', '/')
        $Content = Get-Content -Raw -LiteralPath $File.FullName
        foreach ($Heading in $Headings) {
            Require-Heading -Content $Content -Heading $Heading -Path $RelativePath
        }
    }
}

function Get-GitStatusRows {
    $Rows = @()

    try {
        $Lines = & git -C $RepoRoot status --porcelain 2>$null
        if ($LASTEXITCODE -ne 0) {
            Add-Result "WARN" "Git status could not be read; skipping Git-aware checks." ""
            return @()
        }
    } catch {
        Add-Result "WARN" "Git is not available; skipping Git-aware checks." ""
        return @()
    }

    foreach ($Line in $Lines) {
        if ($Line.Length -lt 4) {
            continue
        }

        $Status = $Line.Substring(0, 2)
        $Path = $Line.Substring(3).Trim()
        if ($Path -match " -> ") {
            $Path = ($Path -split " -> ")[-1].Trim()
        }

        $Rows += [pscustomobject]@{
            Status = $Status
            Path = ($Path -replace '\\', '/')
        }
    }

    return $Rows
}

function Test-AgentArtifactPath {
    param([string]$Path)

    if ($Path -eq "AGENTS.md") {
        return $true
    }

    foreach ($Prefix in @(
        "docs/agent/",
        "docs/plans/",
        "docs/decisions/",
        "docs/reports/",
        "docs/handoffs/",
        ".agents/"
    )) {
        if ($Path.StartsWith($Prefix)) {
            return $true
        }
    }

    return $false
}

Write-Host "Agent check root: $RepoRoot"

$RequiredPaths = @(
    @("AGENTS.md", "Project agent contract"),
    @("docs/agent/PROJECT_STATE.md", "Project state index"),
    @("docs/agent/DIRECTORY_STRUCTURE.md", "Directory contract"),
    @("docs/agent/templates", "Template directory"),
    @("docs/plans", "Plans directory"),
    @("docs/decisions", "Decisions directory"),
    @("docs/reports/dev", "Dev reports directory"),
    @("docs/reports/qa", "QA reports directory"),
    @("docs/reports/review", "Review reports directory"),
    @("docs/reports/delivery", "Delivery reports directory"),
    @("docs/handoffs", "Handoffs directory"),
    @("scripts/agent-check.ps1", "Agent check script")
)

foreach ($Item in $RequiredPaths) {
    Require-Path -RelativePath $Item[0] -Description $Item[1]
}

$RequiredTemplates = @(
    "AGENTS_TEMPLATE.md",
    "PROJECT_STATE_TEMPLATE.md",
    "PLAN_TEMPLATE.md",
    "PLAN_ADDENDUM_TEMPLATE.md",
    "ADR_TEMPLATE.md",
    "DEV_REPORT_TEMPLATE.md",
    "QA_REPORT_TEMPLATE.md",
    "REVIEW_REPORT_TEMPLATE.md",
    "DELIVERY_REPORT_TEMPLATE.md",
    "HANDOFF_TEMPLATE.md"
)

foreach ($Template in $RequiredTemplates) {
    Require-Path -RelativePath "docs/agent/templates/$Template" -Description "Template $Template"
}

if (Test-RepoPath "docs/agent/PROJECT_STATE.md") {
    $StateContent = Read-RepoText "docs/agent/PROJECT_STATE.md"

    foreach ($Heading in @(
        "Identity",
        "Current Status",
        "Latest Artifacts",
        "Open Risks",
        "Blockers",
        "Next Recommended Action",
        "Last Verified Commands",
        "Update Rules"
    )) {
        Require-Heading -Content $StateContent -Heading $Heading -Path "docs/agent/PROJECT_STATE.md"
    }

    $LatestArtifacts = Get-MarkdownSection -Content $StateContent -Heading "Latest Artifacts"
    $SkippableStatuses = @("missing", "optional", "not-needed", "not needed", "tbd", "planned")

    foreach ($Line in ($LatestArtifacts -split "\r?\n")) {
        if ($Line -notmatch '^\|\s*([^|]+?)\s*\|\s*`?([^|`]+)`?\s*\|\s*([^|]+?)\s*\|') {
            continue
        }

        $Artifact = $Matches[1].Trim()
        $ArtifactPath = Normalize-AgentPath $Matches[2]
        $Status = $Matches[3].Trim().ToLowerInvariant()

        if ($Artifact -eq "Artifact" -or $Artifact -match "^-+$") {
            continue
        }

        if ($ArtifactPath -eq "TBD" -or $SkippableStatuses.Contains($Status)) {
            Add-Result "PASS" "State row '$Artifact' is allowed to skip path check because status is '$Status'." "docs/agent/PROJECT_STATE.md"
            continue
        }

        if (Test-RepoPath $ArtifactPath) {
            Add-Result "PASS" "State row '$Artifact' points to an existing path." $ArtifactPath
        } else {
            Add-Result "FAIL" "State row '$Artifact' points to a missing path." $ArtifactPath
        }
    }
}

$PlanFiles = Get-ArtifactFiles "docs/plans"
$BasePlanFiles = @($PlanFiles | Where-Object { $_.Name -notmatch "-addendum-\d+\.md$" })
$AddendumFiles = @($PlanFiles | Where-Object { $_.Name -match "-addendum-\d+\.md$" })

if ($BasePlanFiles.Count -gt 0) {
    Test-ArtifactHeadings -Files $BasePlanFiles -Headings @("Objective", "Scope", "Acceptance Scenarios", "Validation Strategy", "Risks")
} else {
    Add-Result "WARN" "No plan artifacts found under docs/plans." "docs/plans"
}

if ($AddendumFiles.Count -gt 0) {
    Test-ArtifactHeadings -Files $AddendumFiles -Headings @("Reason For Addendum", "Plan Changes", "Updated Acceptance Scenarios", "Updated Validation Strategy")
}

$AdrFiles = @(Get-ArtifactFiles "docs/decisions" | Where-Object { $_.Name -match "^ADR-\d{3}-.+\.md$" })
if ($AdrFiles.Count -gt 0) {
    Test-ArtifactHeadings -Files $AdrFiles -Headings @("Context", "Decision", "Alternatives Considered", "Consequences")
}

$DevReportFiles = @(Get-ArtifactFiles "docs/reports/dev")
if ($DevReportFiles.Count -gt 0) {
    Test-ArtifactHeadings -Files $DevReportFiles -Headings @("Summary", "Changed Files", "Validation", "Commands", "Results", "Residual Risk")
}

$QaReportFiles = @(Get-ArtifactFiles "docs/reports/qa")
if ($QaReportFiles.Count -gt 0) {
    Test-ArtifactHeadings -Files $QaReportFiles -Headings @("Summary", "Scenarios Tested", "Commands", "Results", "Residual Risk")
}

$ReviewReportFiles = @(Get-ArtifactFiles "docs/reports/review")
if ($ReviewReportFiles.Count -gt 0) {
    Test-ArtifactHeadings -Files $ReviewReportFiles -Headings @("Review Scope", "Findings", "Evidence", "Residual Risk")
}

$DeliveryReportFiles = @(Get-ArtifactFiles "docs/reports/delivery")
if ($DeliveryReportFiles.Count -gt 0) {
    Test-ArtifactHeadings -Files $DeliveryReportFiles -Headings @("Delivery Decision", "Scope Approved", "Evidence Reviewed", "Residual Risk", "Next Action")
}

$HandoffFiles = @(Get-ArtifactFiles "docs/handoffs")
if ($HandoffFiles.Count -gt 0) {
    Test-ArtifactHeadings -Files $HandoffFiles -Headings @("Objective And Current Owner", "Git State", "Artifact Map", "Validation Evidence", "Next Action")
}

$GitRows = Get-GitStatusRows
if ($GitRows.Count -gt 0) {
    $CodeChanges = @($GitRows | Where-Object {
        $_.Path -ne "" -and
        $_.Path -ne ".gitkeep" -and
        -not (Test-AgentArtifactPath $_.Path)
    })

    if ($CodeChanges.Count -gt 0) {
        if ($DevReportFiles.Count -eq 0 -and $QaReportFiles.Count -eq 0) {
            Add-Result "FAIL" "Code changes exist but no dev or QA report exists." (($CodeChanges | Select-Object -ExpandProperty Path) -join ", ")
        } else {
            Add-Result "PASS" "Code changes have dev or QA report evidence." (($CodeChanges | Select-Object -ExpandProperty Path) -join ", ")
        }
    }

    $ModifiedBasePlans = @($GitRows | Where-Object {
        $_.Status -notmatch "^\?\?" -and
        $_.Path.StartsWith("docs/plans/") -and
        $_.Path.EndsWith(".md") -and
        $_.Path -notmatch "-addendum-\d+\.md$"
    })

    $ChangedAddendumsOrAdrs = @($GitRows | Where-Object {
        ($_.Path.StartsWith("docs/plans/") -and $_.Path -match "-addendum-\d+\.md$") -or
        ($_.Path.StartsWith("docs/decisions/") -and $_.Path -match "^docs/decisions/ADR-\d{3}-.+\.md$")
    })

    if ($ModifiedBasePlans.Count -gt 0 -and $ChangedAddendumsOrAdrs.Count -eq 0) {
        Add-Result "FAIL" "Existing base plan changed without a matching addendum or ADR change." (($ModifiedBasePlans | Select-Object -ExpandProperty Path) -join ", ")
    }
}

foreach ($Result in $Results) {
    $Text = "[{0}] {1}" -f $Result.Level, $Result.Message
    if (-not [string]::IsNullOrWhiteSpace($Result.Path)) {
        $Text = "$Text ($($Result.Path))"
    }

    switch ($Result.Level) {
        "PASS" { Write-Host $Text -ForegroundColor Green }
        "WARN" { Write-Host $Text -ForegroundColor Yellow }
        "FAIL" { Write-Host $Text -ForegroundColor Red }
    }
}

$Failures = @($Results | Where-Object { $_.Level -eq "FAIL" })
$Warnings = @($Results | Where-Object { $_.Level -eq "WARN" })

if ($Failures.Count -gt 0 -or ($Strict -and $Warnings.Count -gt 0)) {
    [Console]::Error.WriteLine(("agent-check failed: {0} failure(s), {1} warning(s)." -f $Failures.Count, $Warnings.Count))
    exit 1
}

Write-Host ("agent-check passed: {0} check(s), {1} warning(s)." -f $Results.Count, $Warnings.Count) -ForegroundColor Green
exit 0
