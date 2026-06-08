# Agent Templates And Check Plan

## Metadata

- Project Slug: coding-workflow-test-1
- Task Slug: agent-templates-and-check
- Created: 2026-06-08-05-26-41
- Owner Mode: architect
- Status: active
- Related State: `docs/agent/PROJECT_STATE.md`

## Objective

Add full reusable templates under `docs/agent/templates/` and implement
`scripts/agent-check.ps1` so the repo-native agent operating layer has both
human-editable examples and a mechanical consistency check.

## Scope

- Add complete templates for project instructions, project state, plans,
  addendums, ADRs, dev reports, QA reports, review reports, delivery reports,
  and handoffs.
- Implement a PowerShell check script that can be run from the repository root
  or from another directory with `-Root`.
- Check required agent files, directories, template files, state links,
  artifact content shape, validation evidence, and basic Git change/report
  consistency.
- Update `docs/agent/PROJECT_STATE.md` to point at the latest plan and later
  reports created during this task.

## Non-Scope

- Do not implement the lightweight repo skill yet.
- Do not add project application code.
- Do not change the remote repository configuration.
- Do not introduce a wrapped `workspace/project` layout.

## Architecture Decisions

- Keep templates as plain Markdown so humans can edit them directly and Codex
  can use them without additional tooling.
- Keep the check script deterministic and dependency-free beyond PowerShell and
  optional Git.
- Make hard checks fail with a non-zero exit code. Keep heuristic checks as
  warnings unless they indicate a direct contract violation.
- Prefer simple heading checks over parsing arbitrary Markdown deeply.

## Acceptance Scenarios

### Happy Path

- Running `powershell -ExecutionPolicy Bypass -File scripts/agent-check.ps1`
  from the repository root reports required files, templates, state links, and
  current artifacts as valid.
- The script exits with code `0` when required artifacts are present and linked
  files exist.
- Each template includes enough sections for Codex to create a useful artifact
  without inventing the format from scratch.

### Edge Cases

- If `PROJECT_STATE.md` points at an active artifact path that does not exist,
  the script reports a failure and exits non-zero.
- If a latest plan exists but lacks acceptance scenarios, the script reports a
  failure.
- If QA reports exist but lack command/result evidence, the script reports a
  failure.
- If the script is run from outside the repo with `-Root`, it resolves paths
  relative to that root.

### Regression Cases

- `TBD`, `missing`, `optional`, and `not-needed` state rows should not cause
  path-existence failures.
- `.gitkeep` files should not be treated as real artifacts.
- The script should not require the future lightweight skill to exist yet.

### Ambiguous Cases

- Detecting whether a plan changed semantically is heuristic. The first script
  version should catch obvious modified plan files without a matching addendum
  or ADR, but it should not claim full semantic detection.

## Validation Strategy

- Run the new script from the repository root.
- Run the new script from the parent directory using `-Root`.
- Run a targeted PowerShell parse check on the script.
- Inspect Git status after edits to confirm intended files changed.

## Risks

- Overly strict checks could make lightweight use annoying. Mitigate by failing
  only clear contract violations and leaving heuristics as warnings where
  possible.
- Markdown parsing can be brittle. Mitigate by using simple heading and table
  conventions already defined by the templates.

## Next Owner

- developer
