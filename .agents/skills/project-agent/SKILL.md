---
name: project-agent
description: Maintain a repo-native agent operating layer for supervised, resumable Codex development. Use when a task asks for project plans, PROJECT_STATE.md updates, agent artifacts, dev/QA/review/delivery reports, handoffs, or when Codex should follow AGENTS.md and scripts/agent-check.ps1 while doing non-trivial repository work.
---

# Project Agent

Use this skill to keep project memory visible, editable, and resumable while
Codex works in the real repository. Do not impose a rigid multi-agent workflow;
use lightweight owner modes only as thinking postures.

## Read First

From the repository root, read:

1. `AGENTS.md`
2. `docs/agent/PROJECT_STATE.md`
3. `docs/agent/DIRECTORY_STRUCTURE.md` before creating or renaming artifacts
4. The latest artifacts named in `PROJECT_STATE.md` that matter for the task
5. The code, tests, and project docs needed for the current change

Inspect Git state before editing. Preserve unrelated user changes.

## Decide Artifact Need

Treat work as non-trivial when it changes behavior, architecture, data flow,
public APIs, user-facing UI, tests, deployment behavior, security posture, or
more than one logical module.

For non-trivial work:

- Create or update a plan before implementation.
- Create a plan addendum or ADR when reality changes the plan.
- Create a dev report after implementation.
- Create a QA report after verification.
- Create review or delivery reports when risk, release readiness, or the user
  asks for an independent pass.
- Create a handoff when work pauses, context may be lost, or another agent
  should resume.
- Update `docs/agent/PROJECT_STATE.md` after any latest artifact, phase, risk,
  blocker, validation result, or next action changes.

For trivial work, skip artifacts only when the final response explains why no
durable artifact was needed.

## Create Artifacts

Use `docs/agent/templates/` as copyable shapes. Follow naming rules from
`docs/agent/DIRECTORY_STRUCTURE.md`.

Keep artifacts factual:

- Plans record objective, scope, non-scope, acceptance scenarios, validation
  strategy, risks, and next owner mode.
- Addendums record what changed, why, and how acceptance or validation changed.
- ADRs record durable architecture or product decisions and rejected options.
- Dev reports record changed files, implementation notes, acceptance coverage,
  commands, results, known gaps, and residual risk.
- QA reports record scenarios tested, commands, observed results, issues,
  coverage gaps, and residual risk.
- Handoffs record objective, Git state, artifact map, validation evidence,
  risks, and exact next action.

Prefer new timestamped artifacts over rewriting history. Update
`PROJECT_STATE.md` as the compact navigation index.

## Validate

Run project-native tests, lint, typecheck, build, or focused checks when
available. Always record commands and results in the relevant report.

When `scripts/agent-check.ps1` exists, run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1
```

Use `-Strict` for final validation when warnings should block completion.
If validation cannot run, record the exact blocker and residual risk.

## Finish

Before final response, make sure the latest artifacts and
`PROJECT_STATE.md` agree. Summarize changed files, artifacts, validation
commands, results, known gaps, and whether `PROJECT_STATE.md` was updated.
