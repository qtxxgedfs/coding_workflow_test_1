# Agent Templates And Check Dev Report

## Metadata

- Project Slug: coding-workflow-test-1
- Task Slug: agent-templates-and-check
- Created: 2026-06-08-05-42-28
- Owner Mode: developer
- Related Plan: `docs/plans/2026-06-08-05-26-41-agent-templates-and-check.md`
- Status: complete

## Summary

Added the full reusable template set under `docs/agent/templates/` and
implemented `scripts/agent-check.ps1` for mechanical validation of the
repo-native agent operating layer.

## Changed Files

| File | Change | Reason |
| --- | --- | --- |
| `docs/agent/DIRECTORY_STRUCTURE.md` | Added AGENTS and PROJECT_STATE templates to the tree and changed planned checks to implemented checks. | Keep the directory contract aligned with implemented files. |
| `docs/agent/templates/AGENTS_TEMPLATE.md` | Added full project instruction template. | Provide a reusable repo contract example. |
| `docs/agent/templates/PROJECT_STATE_TEMPLATE.md` | Added full project state template. | Provide a fixed current-state entry point example. |
| `docs/agent/templates/PLAN_TEMPLATE.md` | Added full plan template. | Standardize planning artifacts and acceptance scenarios. |
| `docs/agent/templates/PLAN_ADDENDUM_TEMPLATE.md` | Added full addendum template. | Standardize plan evolution records. |
| `docs/agent/templates/ADR_TEMPLATE.md` | Added full ADR template. | Standardize durable decision records. |
| `docs/agent/templates/DEV_REPORT_TEMPLATE.md` | Added full developer report template. | Standardize implementation evidence. |
| `docs/agent/templates/QA_REPORT_TEMPLATE.md` | Added full QA report template. | Standardize verification evidence. |
| `docs/agent/templates/REVIEW_REPORT_TEMPLATE.md` | Added full review report template. | Standardize independent review findings. |
| `docs/agent/templates/DELIVERY_REPORT_TEMPLATE.md` | Added full delivery report template. | Standardize release readiness checks. |
| `docs/agent/templates/HANDOFF_TEMPLATE.md` | Added full handoff template. | Standardize resumable context records. |
| `docs/plans/2026-06-08-05-26-41-agent-templates-and-check.md` | Added task plan. | Satisfy non-trivial work planning contract. |
| `scripts/agent-check.ps1` | Added mechanical checker. | Turn documentation contract into reproducible checks. |

## Implementation Notes

- The check script resolves the repository root from `-Root`, Git, or its own
  script location.
- The script checks required files, directories, templates, `PROJECT_STATE.md`
  headings, active state links, artifact headings, and basic Git/report
  consistency.
- The script intentionally does not require the future lightweight skill yet.
- Initial PowerShell parsing issues around backticks and scalar Git output were
  fixed during implementation.

## Acceptance Coverage

| Scenario | Covered By | Notes |
| --- | --- | --- |
| Full templates exist. | `scripts/agent-check.ps1` template path checks. | Final pass pending after report artifacts exist. |
| Plan has acceptance scenarios. | `scripts/agent-check.ps1` plan heading checks. | Verified in dry run. |
| Code changes require report evidence. | `scripts/agent-check.ps1` Git/report check. | Verified by expected failure before this report existed. |
| Script parses in PowerShell. | Scriptblock parse command. | Passed after string fixes. |

## Validation

## Commands

| Command | Result | Notes |
| --- | --- | --- |
| `$null = [scriptblock]::Create((Get-Content -Raw -LiteralPath 'scripts\agent-check.ps1')); 'parse ok'` | passed | Confirmed script parses after string fixes. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1` | expected-fail | Failed because code changes existed before this dev/QA report existed. |

## Results

- Template files and the script were added successfully.
- The checker reached meaningful contract validation and correctly failed on
  missing report evidence before this report existed.
- Final pass will be recorded in the QA report after `PROJECT_STATE.md` is
  updated to point at the latest artifacts.

## Known Gaps

- Lightweight repo skill remains unimplemented.
- The plan-change detection check is heuristic and detects obvious modified
  base plan files, not semantic changes.

## Residual Risk

- Markdown heading checks are intentionally simple. This is acceptable for the
  first version because the templates define stable headings.

## Next Owner

- qa
