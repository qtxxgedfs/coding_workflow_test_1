# Agent Check Clean Status Fix Plan

## Metadata

- Project Slug: coding-workflow-test-1
- Task Slug: agent-check-clean-status
- Created: 2026-06-08-07-09-32
- Owner Mode: architect
- Status: active
- Related State: `docs/agent/PROJECT_STATE.md`

## Objective

Fix `scripts/agent-check.ps1` so it passes when the Git working tree is clean
and `git status --porcelain` returns no rows.

## Scope

- Patch the Git status result handling in `scripts/agent-check.ps1`.
- Preserve existing checks and output shape.
- Re-run regular and strict agent checks.
- Re-run the `project-agent` skill validator.
- Record the audit conclusion for to-do items 1-9.

## Non-Scope

- Do not add new agent directories.
- Do not change artifact templates unless validation reveals a template issue.
- Do not implement a fresh-thread or subagent forward test in this fix.

## Architecture Decisions

- Wrap `Get-GitStatusRows` with array syntax at the call site so zero, one, or
  many rows all expose `.Count` under PowerShell StrictMode.
- Keep Git-aware checks skipped when there are no Git rows.

## Acceptance Scenarios

### Happy Path

- `scripts/agent-check.ps1` passes on a clean working tree.
- `scripts/agent-check.ps1 -Strict` passes on a clean working tree.

### Edge Cases

- A no-output `git status --porcelain` result is treated as an empty array.
- Existing Git-aware checks still run when there are modified files.

### Regression Cases

- Required files, templates, state links, plans, dev reports, and QA reports are
  still checked.
- `project-agent` skill validation still passes.

### Ambiguous Cases

- This fix does not prove semantic quality of artifacts; it only fixes the
  clean-Git mechanical failure.

## Validation Strategy

- Run `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1`.
- Run `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1 -Strict`.
- Run `quick_validate.py` for `.agents/skills/project-agent`.
- Inspect Git status.

## Risks

- The check script may have similar scalar/array edge cases in future optional
  sections. Mitigation: keep strict checks in the validation routine.

## Next Owner

- developer
