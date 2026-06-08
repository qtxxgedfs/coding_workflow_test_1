# Repo-Native Agent Directory Structure

This repository keeps Codex planning, engineering memory, validation evidence,
and handoff material inside the project. The goal is to make work visible,
editable, reviewable, and easy to resume without requiring the full chat
history.

## Directory Tree

```text
AGENTS.md
docs/
  agent/
    PROJECT_STATE.md
    DIRECTORY_STRUCTURE.md
    templates/
      PLAN_TEMPLATE.md
      PLAN_ADDENDUM_TEMPLATE.md
      ADR_TEMPLATE.md
      DEV_REPORT_TEMPLATE.md
      QA_REPORT_TEMPLATE.md
      REVIEW_REPORT_TEMPLATE.md
      DELIVERY_REPORT_TEMPLATE.md
      HANDOFF_TEMPLATE.md
  plans/
  decisions/
  reports/
    dev/
    qa/
    review/
    delivery/
  handoffs/
scripts/
  agent-check.ps1
.agents/
  skills/
```

## Purpose

| Path | Purpose |
| --- | --- |
| `AGENTS.md` | Stable Codex instructions, project identity, artifact paths, and completion standards. |
| `docs/agent/PROJECT_STATE.md` | Compact current-state index for resuming work. |
| `docs/agent/DIRECTORY_STRUCTURE.md` | This directory and artifact contract. |
| `docs/agent/templates/` | Full examples that Codex can copy when creating artifacts. |
| `docs/plans/` | Base plans and plan addendums for non-trivial work. |
| `docs/decisions/` | ADRs for durable architecture or product decisions. |
| `docs/reports/dev/` | Developer reports with changed files, implementation notes, and validation evidence. |
| `docs/reports/qa/` | QA reports with scenarios, commands, observed results, and residual risk. |
| `docs/reports/review/` | Review reports for diff, security, maintainability, accessibility, or test-gap findings. |
| `docs/reports/delivery/` | Delivery readiness reports for completed or shippable work. |
| `docs/handoffs/` | Resume documents for context loss, thread switches, or paused work. |
| `scripts/agent-check.ps1` | Mechanical check for missing or inconsistent agent artifacts. |
| `.agents/skills/` | Repo-local lightweight skills that teach Codex how to maintain this layer. |

## Artifact Rules

Use artifacts as source-of-truth engineering memory, not decorative reports.

- Plans describe intended behavior, acceptance scenarios, scope, non-scope,
  risks, and validation strategy.
- Plan addendums record implementation discoveries that change the plan.
- ADRs record durable decisions and rejected alternatives.
- Dev reports record changed files, implementation approach, validation
  commands, command results, known gaps, and residual risk.
- QA reports record reproduced scenarios, happy paths, edge cases, regression
  checks, commands, observed results, and remaining risk.
- Review reports record findings grounded in files, diffs, commands, or
  observed behavior.
- Delivery reports record whether the artifact chain supports release or handoff.
- Handoffs record current facts, Git state, artifact map, validation evidence,
  risks, and exact next action.

## Naming Rules

Use lowercase task slugs and local timestamps unless a project standard says
otherwise. Timestamped artifacts use `YYYY-MM-DD-HH-MM-SS` so multiple updates
created on the same day remain sortable and unambiguous.

| Artifact | Pattern |
| --- | --- |
| Plan | `docs/plans/YYYY-MM-DD-HH-MM-SS-task-slug.md` |
| Plan Addendum | `docs/plans/YYYY-MM-DD-HH-MM-SS-task-slug-addendum-N.md` |
| ADR | `docs/decisions/ADR-NNN-short-title.md` |
| Dev Report | `docs/reports/dev/YYYY-MM-DD-HH-MM-SS-task-slug.md` |
| QA Report | `docs/reports/qa/YYYY-MM-DD-HH-MM-SS-task-slug.md` |
| Review Report | `docs/reports/review/YYYY-MM-DD-HH-MM-SS-task-slug.md` |
| Delivery Report | `docs/reports/delivery/YYYY-MM-DD-HH-MM-SS-task-slug.md` |
| Handoff | `docs/handoffs/YYYY-MM-DD-HH-MM-SS-task-slug.md` |

## Automatic Update Contract

Codex may automatically update agent artifacts when the update follows
`AGENTS.md` and is needed to keep project memory accurate.

Codex should update `PROJECT_STATE.md` after creating any new latest artifact.
Codex should create a new artifact instead of rewriting older history when a
task evolves.

Use addendums and ADRs for changed thinking. Use reports for completed evidence.
Use handoffs when work pauses or context may be lost.

## Planned Mechanical Checks

`scripts/agent-check.ps1` should eventually check:

- `AGENTS.md` exists.
- `docs/agent/PROJECT_STATE.md` exists.
- paths named in `PROJECT_STATE.md` exist unless marked `TBD`, `missing`,
  `optional`, or `not-needed`;
- non-trivial work has a plan;
- plans include acceptance scenarios;
- QA reports include commands and results;
- code changes have a dev report or QA report;
- plan changes have an addendum or ADR;
- handoffs include next action.

## Bootstrap Checklist

Use this checklist when applying the structure to a new repository:

1. Create this directory tree.
2. Fill in `AGENTS.md` identity and project-specific commands.
3. Fill in `PROJECT_STATE.md`.
4. Add full templates under `docs/agent/templates/`.
5. Implement `scripts/agent-check.ps1`.
6. Add a lightweight project skill under `.agents/skills/`.
7. Run the check script and fix missing artifacts.
