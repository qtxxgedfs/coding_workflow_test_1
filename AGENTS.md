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

## Agent Artifact Paths

- Current state index: `docs/agent/PROJECT_STATE.md`
- Directory contract: `docs/agent/DIRECTORY_STRUCTURE.md`
- Reusable templates: `docs/agent/templates/`
- Plans and plan addendums: `docs/plans/`
- Architecture decisions: `docs/decisions/`
- Developer reports: `docs/reports/dev/`
- QA reports: `docs/reports/qa/`
- Review reports: `docs/reports/review/`
- Delivery reports: `docs/reports/delivery/`
- Handoffs: `docs/handoffs/`
- Automation and checks: `scripts/`
- Lightweight project skills: `.agents/skills/`

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

## Work Modes

Use these modes as lightweight thinking postures, not as a rigid gate system.

- Architect: clarify scope, risks, architecture decisions, acceptance
  scenarios, state models, and validation strategy.
- Developer: inspect current code and Git state, implement the effective plan,
  add focused regression coverage when feasible, and record evidence.
- QA: verify user value, edge cases, regressions, and report reproducible
  results. Prefer project-native tests over isolated workflow-only tests.
- Review: inspect the diff for bugs, regressions, security issues, maintainance
  risk, accessibility issues, and missing tests.
- Delivery: verify that evidence is coherent enough to hand back to the user.
- Handoff: summarize current facts, changed files, artifacts, validation, open
  risks, and the exact next step.

If a plan is missing, stale, contradictory, unsafe, or mismatched with the
codebase, stop and update planning artifacts before coding.

## Validation

Prefer the project's native build, test, lint, typecheck, and formatting
commands. If no project-native command exists yet, use the smallest
reproducible validation available and record the gap.

When `scripts/agent-check.ps1` exists, run it before finishing non-trivial work
and fix documentation gaps or report the blocker.

## File Naming

Use lowercase slugs where practical.

- Plan: `docs/plans/YYYY-MM-DD-task-slug.md`
- Plan addendum: `docs/plans/YYYY-MM-DD-task-slug-addendum-N.md`
- ADR: `docs/decisions/ADR-NNN-short-title.md`
- Dev report: `docs/reports/dev/YYYY-MM-DD-task-slug.md`
- QA report: `docs/reports/qa/YYYY-MM-DD-task-slug.md`
- Review report: `docs/reports/review/YYYY-MM-DD-task-slug.md`
- Delivery report: `docs/reports/delivery/YYYY-MM-DD-task-slug.md`
- Handoff: `docs/handoffs/YYYY-MM-DD-task-slug.md`

## Final Response Expectations

When finishing non-trivial work, summarize:

- files changed;
- artifacts created or updated;
- validation commands and results;
- known gaps or residual risk;
- whether `PROJECT_STATE.md` was updated.
