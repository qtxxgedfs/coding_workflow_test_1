# Project Agent Contract

Project Name: Coding Workflow Test 1
Project Slug: coding-workflow-test-1
Project Aliases: coding_workflow_test_1, new_1

This repository uses a repo-native agent operating layer. Do not wrap the source
project in a separate `workspace/project` directory. Keep agent memory,
planning, validation, and handoff artifacts in this repository so humans can
inspect, edit, and resume the work.

## Required First Reads

Before non-trivial work, Codex should read:

1. `AGENTS.md`
2. `docs/agent/PROJECT_STATE.md`
3. The latest plan, decision, report, or handoff named in `PROJECT_STATE.md`
4. The code, tests, and project docs needed for the current task

Before editing code, inspect the Git state. Preserve unrelated user changes.

## Agent Documents

- `docs/agent/PROJECT_STATE.md` is the compact current-state entry point.
- `docs/agent/DIRECTORY_STRUCTURE.md` owns directory layout, artifact types,
  and file naming rules.
- `docs/agent/templates/` owns reusable examples for creating new artifacts.

Read `docs/agent/DIRECTORY_STRUCTURE.md` before creating, renaming, or checking
agent artifacts. Keep detailed path and naming rules out of this file.

## Non-Trivial Work

A task is non-trivial when it changes behavior, architecture, data flow, public
APIs, user-facing UI, tests, deployment behavior, security posture, or more than
one logical module. Non-trivial work should leave durable documentation.

Small edits such as typo fixes, comments, formatting-only changes, or simple
one-line mechanical fixes may skip plan/report artifacts, but the final answer
should say why no artifact was needed.

## Documentation Contract

For non-trivial work:

- Create or update a plan before implementation.
- Convert user value into acceptance scenarios, including happy paths, edge
  cases, regressions, and ambiguous cases that need decisions.
- Identify important state transitions for interactive, workflow, or
  data-processing behavior.
- Record validation expectations before coding when practical.
- If implementation reality changes the plan, create a plan addendum or ADR.
- Record changed files, validation commands, command results, known gaps, and
  residual risk in the appropriate report.
- Update `docs/agent/PROJECT_STATE.md` whenever the current phase, latest
  artifacts, open risks, blockers, or next action changes.
- Write a handoff before pausing long work, switching threads, or when context
  may be lost.

## Codex May Update Agent Documents

Codex may and should update agent documents when:

- implementation changes the plan;
- a risk is discovered, resolved, or reclassified;
- validation results change;
- the task reaches a new phase;
- the next recommended action changes;
- user edits alter the source of truth;
- context may be lost or another agent needs to resume.

Codex should not rewrite historical artifacts in place unless the user asks.
Prefer append-only addendums, new reports, new ADRs, or targeted updates to
`PROJECT_STATE.md`.

## Operating Posture

Use lightweight modes only as thinking postures, not as a rigid workflow:
architect, developer, QA, review, delivery, handoff.

Detailed role behavior belongs in repo skills, templates, or role documents,
not in this file.

If a plan is missing, stale, contradictory, unsafe, or mismatched with the
codebase, stop and update planning artifacts before coding.

## Validation

Prefer the project's native build, test, lint, typecheck, and formatting
commands. If no project-native command exists yet, use the smallest
reproducible validation available and record the gap.

When `scripts/agent-check.ps1` exists, run it before finishing non-trivial work
and fix documentation gaps or report the blocker.

## Final Response Expectations

When finishing non-trivial work, summarize:

- files changed;
- artifacts created or updated;
- validation commands and results;
- known gaps or residual risk;
- whether `PROJECT_STATE.md` was updated.
