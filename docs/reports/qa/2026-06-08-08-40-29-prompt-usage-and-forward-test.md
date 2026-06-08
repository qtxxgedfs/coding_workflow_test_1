# Prompt Usage And Forward Test QA Report

## Metadata

- Project Slug: coding-workflow-test-1
- Task Slug: prompt-usage-and-forward-test
- Created: 2026-06-08-08-40-29
- Owner Mode: QA
- Related Plan: `docs/plans/2026-06-08-08-40-29-prompt-usage-and-forward-test.md`
- Related Dev Report: `docs/reports/dev/2026-06-08-08-40-29-prompt-usage-and-forward-test.md`
- Status: pass

## Summary

QA verified that prompt usage is documented, mechanical checks pass, and a
fresh-thread forward-test can reconstruct the project state from repository
documents.

## Scenarios Tested

| Scenario | Type | Result | Evidence |
| --- | --- | --- | --- |
| Prompt guide exists and covers expected modes. | happy path | passed | `PROMPT_USAGE.md` covers default, implementation, planning, existing-plan continuation, QA/review, handoff, fresh-thread test, and trivial work prompts. |
| Agent mechanical checks pass. | regression | passed | `agent-check.ps1` passed with 118 checks and 0 warnings. |
| Strict checks pass. | edge case | passed | `agent-check.ps1 -Strict` passed with 118 checks and 0 warnings. |
| `project-agent` skill remains valid. | regression | passed | `quick_validate.py` reported "Skill is valid!". |
| Fresh-thread forward-test can reconstruct state. | forward-test | passed | Thread `019ea741-f032-7f40-ab7c-cf0ede205c23` found `$project-agent`, read repo docs, summarized project/current artifacts/completed work/risks/next action, and did not modify files. |

## Commands

| Command | Result | Notes |
| --- | --- | --- |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1` | passed | Passed with 118 checks and 0 warnings before recording final forward-test evidence. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1 -Strict` | passed | Strict run passed with 118 checks and 0 warnings before recording final forward-test evidence. |
| `$Target = Join-Path $env:TEMP 'codex-pyyaml-validate'; $env:PYTHONPATH = $Target; python C:\Users\wangx\.codex\skills\.system\skill-creator\scripts\quick_validate.py .agents\skills\project-agent` | passed | Skill validator reported "Skill is valid!". |
| `fresh thread: Use $project-agent ... fresh-thread forward test` | passed | Created thread `019ea741-f032-7f40-ab7c-cf0ede205c23`; it completed the requested state reconstruction without file edits. |
| `git status --short --branch` | passed | Confirmed expected prompt usage artifacts were changed before commit. |

## Results

- Item 8 is complete: prompt usage now has a standalone lightweight guide.
- Item 9 is complete enough for the planned fresh-thread proof: a separate
  Codex thread discovered the repo-local skill and reconstructed state from
  repository documents only.

## Issues Found

- None so far.

## Coverage Gaps

- No subagent orchestration script was added. This is acceptable because the
  requested next step allowed a fresh-thread forward-test as the item 9 proof.

## Residual Risk

- A fresh-thread summary is a useful proxy, but real task performance still
  needs item 10 small-project trial.

## Next Owner

- review
