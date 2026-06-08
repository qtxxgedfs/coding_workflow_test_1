# Project Agent Contract

Project Name: Example Product
Project Slug: example-product
Project Aliases: example_product, example-app

This repository uses a repo-native agent operating layer. Keep agent memory,
planning, validation, and handoff artifacts inside the repository so humans can
inspect, edit, and resume the work.

## Required First Reads

Before non-trivial work, Codex should read:

1. `AGENTS.md`
2. `docs/agent/PROJECT_STATE.md`
3. The latest relevant artifacts named in `PROJECT_STATE.md`
4. The code, tests, and project docs needed for the current task

Before editing code, inspect the Git state. Preserve unrelated user changes.

## Agent Document Sources

- Current state entry point: `docs/agent/PROJECT_STATE.md`
- Directory, naming, and artifact contract:
  `docs/agent/DIRECTORY_STRUCTURE.md`
- Reusable artifact examples: `docs/agent/templates/`

Keep detailed path, naming, and artifact-shape rules in
`docs/agent/DIRECTORY_STRUCTURE.md` rather than repeating them here.

## Project-Specific Commands

- Build: `TBD`
- Test: `TBD`
- Lint: `TBD`
- Typecheck: `TBD`
- Format: `TBD`
- Agent check: `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1`

Prefer project-native validation commands. If no native command exists yet, use
the smallest reproducible validation available and record the gap.

## Non-Trivial Work

A task is non-trivial when it changes behavior, architecture, data flow, public
APIs, user-facing UI, tests, deployment behavior, security posture, or more than
one logical module.

For non-trivial work, maintain the agent artifact chain described in
`docs/agent/DIRECTORY_STRUCTURE.md` and update `docs/agent/PROJECT_STATE.md`
when the current phase, latest artifacts, risks, blockers, validation evidence,
or next action changes.

Small typo, comment, formatting-only, or one-line mechanical fixes may skip
plan/report artifacts. Say why no artifact was needed in the final response.

## Codex May Update Agent Documents

Codex may and should update agent documents when doing so keeps project memory
accurate, especially after plan changes, validation changes, risk changes,
phase changes, user edits to the source of truth, or possible context loss.

Do not rewrite historical artifacts in place unless the user asks. Prefer new
addendums, reports, ADRs, handoffs, or targeted updates to `PROJECT_STATE.md`.

## Operating Posture

Use lightweight modes as thinking postures, not as a rigid workflow:
architect, developer, QA, review, delivery, handoff.

If a plan is missing, stale, contradictory, unsafe, or mismatched with the
codebase, stop and update planning artifacts before coding.

## Final Response Expectations

When finishing non-trivial work, summarize:

- files changed;
- artifacts created or updated;
- validation commands and results;
- known gaps or residual risk;
- whether `PROJECT_STATE.md` was updated.
