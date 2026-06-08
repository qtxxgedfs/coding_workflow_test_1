# Small Project Trial Plan

## Metadata

- Project Slug: coding-workflow-test-1
- Task Slug: small-project-trial
- Created: 2026-06-08-09-20-52
- Owner Mode: architect
- Status: active
- Related State: `docs/agent/PROJECT_STATE.md`

## Objective

Run item 10 by using the repo-native agent operating layer on a small but real
project, then record whether the layer is lightweight, low-friction, and useful
for faster Codex handoff.

## Scope

- Create a static web project in `D:\codex\coding_workflow_test_1\new_1_test_1`.
- Build a usable local decision and issue triage board with sample data,
  create/edit/delete workflow, filters, sorting, and local persistence.
- Bootstrap the small project with its own `AGENTS.md`,
  `docs/agent/PROJECT_STATE.md`, artifact directories, handoff directory,
  repo-local skill, and lightweight `scripts/agent-check.ps1`.
- Create plan, decision, dev, QA, review, delivery, and handoff artifacts for
  the trial project where useful.
- Run validation for both the main repository and the small project, including
  regular and strict agent checks.
- Commit the main repository changes and the small project changes locally.

## Non-Scope

- Do not push either repository.
- Do not introduce a package manager or build step unless static files become
  insufficient.
- Do not add heavyweight multi-agent orchestration; use the optional review
  layer only as a lightweight independent pass unless a callable subagent is
  available and worthwhile.

## Current Context

The main repository already has the repo-native operating layer, prompt usage
guide, local `project-agent` skill, and passing `agent-check.ps1` checks. The
next recommended action is the item 10 small-project trial. The trial directory
already exists and is empty.

## Architecture Decisions

- Use a dependency-free static HTML/CSS/JS app so the trial focuses on the
  operating layer rather than framework setup.
- Make `new_1_test_1` an independent Git repository. This better verifies
  whether a fresh project can carry the layer itself, while keeping main repo
  trial evidence separate and easy to review.
- Adapt the agent layer instead of copying every template verbatim. The test is
  meant to judge lightweight usefulness, so the small project should include the
  essential contract and checks without becoming documentation-heavy.

## State Or Data Model

The app stores triage items in browser `localStorage`. Each item has an id,
title, type, status, impact, owner, due date, tags, notes, created timestamp,
and updated timestamp. Users can create, edit, delete, filter by status/type,
search text, sort by due date or impact, and reset to sample data.

## Acceptance Scenarios

### Happy Path

- A user can open the static app and see a populated board with meaningful
  triage and decision items.
- A user can add a new item, edit it, delete it, and see changes reflected in
  counts and board columns.
- Filters, search, and sorting change the visible items without losing data.
- Refreshing the page preserves user-created items via `localStorage`.

### Edge Cases

- Empty title input is rejected with clear inline validation.
- Empty filter results show an empty state instead of broken layout.
- Reset sample data restores a known useful state.

### Regression Cases

- Main repository `agent-check.ps1` regular and strict checks still pass.
- Small project `scripts/agent-check.ps1` regular and strict checks pass.
- Small project can be validated without package install.

### Ambiguous Cases

- If subagent tooling is unavailable or disproportionate for this small task,
  record a manual independent review/QA pass with evidence instead.

## Validation Strategy

- Run static syntax checks for the small project JavaScript.
- Run small project regular and strict `scripts/agent-check.ps1`.
- Run main repository regular and strict `scripts/agent-check.ps1`.
- Serve or open the static app and verify core workflows manually or with
  browser automation where available.
- Record commands, observed results, gaps, and residual risks in reports.

## Risks

- The documentation layer may feel too heavy for a tiny app. Mitigation: track
  which artifacts were useful versus cumbersome in the review and delivery
  reports.
- Browser-only persistence can be hard to prove from command-line checks.
  Mitigation: use JavaScript-level tests and a browser smoke test if tooling is
  available.
- The small check script could become too specific. Mitigation: keep it focused
  on existence, latest artifact links, and command evidence.

## Implementation Notes

- Prefer `index.html`, `styles.css`, and `app.js`.
- Keep UI dense and work-focused rather than marketing-like.
- Reuse the main repo artifact naming conventions.
- Keep final evidence factual, including friction and improvement opportunities.

## Next Owner

- developer
