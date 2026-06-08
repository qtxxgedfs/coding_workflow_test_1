# Project Agent Skill Plan

## Metadata

- Project Slug: coding-workflow-test-1
- Task Slug: project-agent-skill
- Created: 2026-06-08-06-43-37
- Owner Mode: architect
- Status: active
- Related State: `docs/agent/PROJECT_STATE.md`

## Objective

Implement the lightweight repo-local `project-agent` skill so Codex can
automatically follow the agent document contract, read `PROJECT_STATE.md`,
create or update artifacts, and run `scripts/agent-check.ps1` for non-trivial
work.

## Scope

- Create `.agents/skills/project-agent/SKILL.md`.
- Keep the skill concise and focused on maintaining repo-native agent
  documents.
- Include trigger metadata that covers plans, project state updates, reports,
  handoffs, and non-trivial supervised development tasks.
- Use the existing repo artifact templates and `agent-check.ps1` instead of
  adding duplicate scripts or reference files inside the skill.
- Update `docs/agent/PROJECT_STATE.md` to point at the new skill artifacts.
- Validate the skill structure and the repo agent contract.

## Non-Scope

- Do not reintroduce a wrapped `workspace/project` directory.
- Do not implement a heavy role-gated workflow.
- Do not add subagent orchestration yet.
- Do not add external MCP or GitHub automation.
- Do not change application source code.

## Architecture Decisions

- Store the skill under `.agents/skills/project-agent/` so it is repo-local and
  discoverable by Codex when working in this repository.
- Keep `SKILL.md` as the only instruction artifact for the skill. The project
  already owns templates, checks, and directory rules.
- Use the skill as a lightweight operating contract, not a rigid owner sequence.
- Let `AGENTS.md`, `PROJECT_STATE.md`, and `DIRECTORY_STRUCTURE.md` remain the
  source of truth for project-specific behavior.

## Acceptance Scenarios

### Happy Path

- Codex can trigger `$project-agent` for non-trivial work that needs durable
  plans, reports, state updates, or handoff artifacts.
- The skill tells Codex to read `AGENTS.md`, `PROJECT_STATE.md`, and
  `DIRECTORY_STRUCTURE.md` before creating or updating artifacts.
- The skill points Codex at `docs/agent/templates/` and the existing naming
  rules instead of inventing artifact formats.
- The skill instructs Codex to run `scripts/agent-check.ps1` before finishing
  non-trivial work.

### Edge Cases

- Trivial edits can skip artifacts only when the final response explains why.
- If a plan is stale or contradicted by implementation reality, Codex creates
  an addendum or ADR before continuing.
- If validation cannot run, Codex records the blocker and residual risk.

### Regression Cases

- The skill does not duplicate the heavy `coding-agent-workflow` route.
- The skill does not add project-specific scripts that already exist at the
  repository root.
- `agents/openai.yaml` keeps a default prompt that explicitly names
  `$project-agent`.

### Ambiguous Cases

- The skill cannot decide semantic quality by itself. It relies on Codex
  judgment plus `agent-check.ps1` for mechanical consistency.

## Validation Strategy

- Run the skill validation script from `skill-creator`.
- Run `scripts/agent-check.ps1`.
- Run `scripts/agent-check.ps1 -Strict`.
- Inspect Git status to confirm only intended files changed.

## Risks

- The skill may still be too broad if it tries to explain every artifact type.
  Mitigation: keep detailed artifact rules in existing repo docs and templates.
- Implicit triggering depends on frontmatter description quality. Mitigation:
  include concrete trigger terms in the skill description.
- The skill has not yet been forward-tested in a fresh thread or subagent.
  Mitigation: record this as residual risk.

## Next Owner

- developer
