# Agent Templates And Check QA Report

## Metadata

- Project Slug: coding-workflow-test-1
- Task Slug: agent-templates-and-check
- Created: 2026-06-08-05-42-28
- Owner Mode: QA
- Related Plan: `docs/plans/2026-06-08-05-26-41-agent-templates-and-check.md`
- Related Dev Report: `docs/reports/dev/2026-06-08-05-42-28-agent-templates-and-check.md`
- Status: pass

## Summary

QA confirms the checker parses, catches missing-report evidence before reports
exist, and passes from both the repository root and a parent directory with
`-Root` after artifacts and state links are in place.

## Scenarios Tested

| Scenario | Type | Result | Evidence |
| --- | --- | --- | --- |
| Script parses in Windows PowerShell. | happy path | passed | Scriptblock parse command returned `parse ok`. |
| Code changes without report evidence fail. | regression | passed | `agent-check.ps1` returned non-zero before this report existed. |
| Latest plan contains acceptance scenarios. | happy path | passed | `agent-check.ps1` recognized the plan headings during dry run. |
| Repository-root check passes. | happy path | passed | Root run reported `agent-check passed: 56 check(s), 0 warning(s)`. |
| Parent-directory `-Root` check passes. | edge case | passed | Parent run reported `agent-check passed: 56 check(s), 0 warning(s)`. |

## Commands

| Command | Result | Notes |
| --- | --- | --- |
| `$null = [scriptblock]::Create((Get-Content -Raw -LiteralPath 'scripts\agent-check.ps1')); 'parse ok'` | passed | Syntax check passed. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1` | expected-fail | Failed before dev/QA report artifacts existed. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1` | passed | Root run passed with 56 checks and 0 warnings after reports and state links existed. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File new_1\scripts\agent-check.ps1 -Root D:\codex\coding_workflow_test_1\new_1` | passed | Parent-directory run passed with 56 checks and 0 warnings. |

## Results

- The checker parses and validates the repository contract successfully.
- The checker caught a real documentation gap before reports were created.
- Final validation passed from both supported invocation styles.

## Issues Found

- None remaining so far.

## Coverage Gaps

- None for the first checker version.

## Residual Risk

- The script validates artifact shape, not the full semantic quality of each
  report.

## Next Owner

- review
