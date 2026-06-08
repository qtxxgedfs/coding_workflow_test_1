# Project State

This file is the fixed entry point for humans and Codex to resume work. Keep it
short, current, and linked to the durable artifacts that contain detail.

## Identity

- Project Name: Coding Workflow Test 1
- Project Slug: coding-workflow-test-1
- Project Aliases: coding_workflow_test_1, new_1
- Repository: https://github.com/qtxxgedfs/coding_workflow_test_1

## Current Status

- Current Objective: Establish a repo-native agent operating layer for
  supervised, resumable Codex development.
- Current Phase: planning
- Current Owner Mode: architect
- Last Updated: 2026-06-08

Allowed phases:

- planning
- implementation
- qa
- review
- delivery
- blocked
- shipped

## Latest Artifacts

| Artifact | Path | Status | Notes |
| --- | --- | --- | --- |
| Directory Contract | `docs/agent/DIRECTORY_STRUCTURE.md` | active | Defines the repo-native agent tree. |
| Latest Plan | `TBD` | missing | Create before the first non-trivial implementation task. |
| Latest Addendum | `TBD` | not-needed | Use when implementation changes a plan. |
| Latest Decision | `TBD` | not-needed | Use ADRs for architecture or product direction changes. |
| Latest Dev Report | `TBD` | missing | Create after non-trivial implementation. |
| Latest QA Report | `TBD` | missing | Create after validation of non-trivial work. |
| Latest Review Report | `TBD` | optional | Use for independent review or high-risk diffs. |
| Latest Delivery Report | `TBD` | optional | Use before shipping or handing off completed work. |
| Latest Handoff | `TBD` | missing | Create before pausing or switching threads. |

## Open Risks

- The documentation contract exists, but `scripts/agent-check.ps1` is not yet
  implemented.
- The lightweight project skill is not yet implemented.
- The template files under `docs/agent/templates/` are not yet populated.

## Blockers

- None.

## Next Recommended Action

1. Create the first plan artifact for implementing `scripts/agent-check.ps1`.
2. Add full templates under `docs/agent/templates/`.
3. Implement the lightweight project skill under `.agents/skills/`.

## Last Verified Commands

| Command | Result | Notes |
| --- | --- | --- |
| `git ls-remote https://github.com/qtxxgedfs/coding_workflow_test_1.git` | passed | Remote repository is reachable and appears empty. |
| `git init -b main` | passed | Initialized local repository in `new_1`. |
| `git remote add origin https://github.com/qtxxgedfs/coding_workflow_test_1.git` | passed | Connected local repository to GitHub origin. |

## Recently Changed Files

- `AGENTS.md`
- `docs/agent/PROJECT_STATE.md`
- `docs/agent/DIRECTORY_STRUCTURE.md`

## Update Rules

Update this file whenever:

- the current objective changes;
- the phase changes;
- a latest artifact path changes;
- risks or blockers change;
- validation commands are run;
- the next recommended action changes;
- a handoff is needed.

Keep detailed reasoning in the linked artifacts. Keep this file as a compact
navigation index.
