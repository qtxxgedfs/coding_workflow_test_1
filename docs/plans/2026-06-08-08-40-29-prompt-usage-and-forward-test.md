# Prompt Usage And Forward Test Plan

## Metadata

- Project Slug: coding-workflow-test-1
- Task Slug: prompt-usage-and-forward-test
- Created: 2026-06-08-08-40-29
- Owner Mode: architect
- Status: active
- Related State: `docs/agent/PROJECT_STATE.md`

## Objective

Complete to-do item 8 by adding a lightweight prompt usage guide, then complete
to-do item 9 by running a fresh-thread forward test for the `project-agent`
layer.

## Scope

- Add `docs/agent/PROMPT_USAGE.md` with short reusable prompt examples.
- Cover default use, non-trivial implementation, planning, existing-plan
  continuation, QA/review, handoff, fresh-thread testing, and trivial work.
- Update `docs/agent/PROJECT_STATE.md` to point at this task.
- Run `scripts/agent-check.ps1` and strict mode.
- Validate `.agents/skills/project-agent`.
- Create a fresh Codex thread to test whether another context can resume from
  repo documents.

## Non-Scope

- Do not change project source code.
- Do not add subagent orchestration scripts.
- Do not require prompt examples to duplicate the full `AGENTS.md` contract.

## Architecture Decisions

- Keep prompt examples short because durable rules belong in `AGENTS.md`,
  `PROJECT_STATE.md`, and the skill.
- Treat fresh-thread testing as the proof for item 9 instead of adding a heavy
  subagent workflow.
- Keep review/subagent infrastructure optional until a real high-risk task
  needs it.

## Acceptance Scenarios

### Happy Path

- A user can copy a short prompt from `PROMPT_USAGE.md` to invoke
  `$project-agent`.
- The guide explains how to request planning-only, implementation, QA/review,
  handoff, and fresh-thread forward tests.
- `PROJECT_STATE.md` no longer lists missing prompt usage as an open risk.

### Edge Cases

- Trivial work guidance explains when artifacts may be skipped.
- Existing-plan continuation explains when to create addendums or ADRs.
- QA/review guidance separates verification from implementation.

### Regression Cases

- `project-agent` skill validation still passes.
- `agent-check.ps1` regular and strict checks pass.
- The guide does not reintroduce the heavy role-gated workflow.

### Ambiguous Cases

- The forward-test thread may provide a summary without editing files. That is
  acceptable if it proves the state can be reconstructed from repo artifacts.

## Validation Strategy

- Run `scripts/agent-check.ps1`.
- Run `scripts/agent-check.ps1 -Strict`.
- Run `quick_validate.py` for `.agents/skills/project-agent`.
- Create a fresh thread with the forward-test prompt and review its response.
- Inspect Git status.

## Risks

- The prompt guide could become too long and tempt users to paste policy into
  every prompt. Mitigation: keep examples short and point durable rules at
  repository docs.
- Thread tool availability may limit fresh-thread testing. Mitigation: record
  the blocker if a new thread cannot be created.

## Next Owner

- developer
