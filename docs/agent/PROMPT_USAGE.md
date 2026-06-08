# Project Agent Prompt Usage

Use this guide when starting work that should follow the repo-native agent
document contract. Keep prompts short; let `AGENTS.md`,
`docs/agent/PROJECT_STATE.md`, and `.agents/skills/project-agent/SKILL.md`
carry the durable rules.

## Default Prompt

Use this when you want Codex to maintain plans, reports, state, and handoff
artifacts while doing a task:

```text
Use $project-agent to keep project plans, reports, state, and handoff artifacts current while doing this task.
```

## Non-Trivial Implementation

Use this for behavior, architecture, API, UI, test, or multi-file changes:

```text
Use $project-agent.
Implement <task>.
Keep this work supervised and resumable: read AGENTS.md and PROJECT_STATE.md,
create or update the needed plan/report artifacts, update PROJECT_STATE.md,
and run scripts/agent-check.ps1 before finishing.
```

## Planning First

Use this when the idea is fuzzy or should not be coded immediately:

```text
Use $project-agent in planning mode.
Clarify scope, risks, acceptance scenarios, non-scope, and validation strategy.
Write the plan artifact, update PROJECT_STATE.md, and stop before editing code.
```

## Implementation From Existing Plan

Use this when a plan already exists:

```text
Use $project-agent.
Continue from the latest plan in PROJECT_STATE.md.
If the plan is stale or contradicted by the codebase, create an addendum or ADR
before implementation. Record validation and residual risk in the dev/QA reports.
```

## QA Or Review Pass

Use this when you want an independent check instead of new implementation:

```text
Use $project-agent in QA/review posture.
Read PROJECT_STATE.md and the latest plan/dev report.
Verify acceptance scenarios, edge cases, regressions, and evidence quality.
Write a QA or review report, update PROJECT_STATE.md, and run agent-check.
```

## Handoff

Use this before pausing, switching threads, or asking another agent to resume:

```text
Use $project-agent to create a handoff.
Compare conversation context with Git state and artifacts.
Write the handoff with verified facts, open risks, validation evidence, and the
exact next action. Update PROJECT_STATE.md.
```

## Fresh-Thread Forward Test

Use this in a new thread to verify that the repository documents are enough for
Codex to resume without the original conversation:

```text
Use $project-agent.
This is a fresh-thread forward test. Do not rely on prior conversation context.
Read AGENTS.md and docs/agent/PROJECT_STATE.md, then report:
1. what the project is,
2. which artifacts are current,
3. what has been completed,
4. what remains risky or incomplete,
5. the next recommended action.
Do not modify files unless the project contract requires a report for this test.
```

## Trivial Work

For typo fixes or one-line mechanical edits, artifacts may be skipped:

```text
Make this trivial edit: <task>.
If no plan/report artifact is needed, explain why in the final response.
```

## Prompt Rules

- Mention `$project-agent` when durable project memory should be maintained.
- Name a specific artifact path when you want Codex to continue from it.
- Ask for planning-only work when code should not be edited yet.
- Ask for QA/review posture when the desired output is verification, not
  implementation.
- Ask for a handoff before context may be lost.
- Keep detailed policy out of prompts; update `AGENTS.md` or this guide when a
  pattern should persist.
