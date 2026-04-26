# agent-skills

Skills, sub-agents, hooks, and guides for AI coding agents (Claude Code,
Codex, Cursor, etc.).

One source tree, organized for humans by category, flattened on install to
whatever each agent expects. Inspired by
[skillkit](https://github.com/rohitg00/skillkit).

## Layout

```
.
├── install.sh        # symlink-based installer (idempotent, with backups)
├── skills/
│   ├── personal/     # how I like to work, non-technical helpers
│   └── coding/       # languages, frameworks, tools, style
├── agents/           # sub-agent definitions (Expert Review Board, etc.)
├── hooks/            # shell scripts for Claude Code (settings.json wiring)
└── guides/
    ├── personal/
    └── coding/       # longer-form process docs referenced by skills
```

## What's a skill?

A directory with a `SKILL.md`:

```
---
name: my-skill
description: One line, precise. Used for skill matching.
---

# my-skill
...body...
```

Categories are for humans. Claude Code reads skills from a flat
`~/.claude/skills/` directory, so `install.sh` symlinks each skill out of its
category into that flat path.

## Sub-agents (Expert Review Board)

`agents/*.md` are specialist sub-agent definitions invocable from any Claude
Code session via the `Agent` tool (`subagent_type=<name>`).

Standing reviewers (design-doc panel):

- **security-reviewer** — auth, secrets, trust boundaries, supply chain
- **scalability-reviewer** — throughput, tail latency, cost at scale
- **reliability-reviewer** — failure modes, blast radius, SLOs, recovery
- **devex-reviewer** — API ergonomics, docs, debuggability, onboarding
- **operations-reviewer** — deploy, rollback, monitoring, ownership
- **data-reviewer** — schema, retention, privacy, migrations

Business-launch panel (paired with the `business-launch` skill):

- **launch-product-advisor** — user, wedge, JTBD (Cagan lens)
- **launch-design-advisor** — conviction, restraint (Rams/Ive)
- **launch-engineering-advisor** — RLS, integrity, failure modes, scale
- **launch-growth-advisor** — activation, loops, funnels (Ellis/Balfour)
- **launch-finance-advisor** — unit economics, gross margin
- **launch-legal-advisor** — privacy, ToS, consent, refund
- **launch-customer-advisor** — first-run experience, friction
- **launch-brand-advisor** — name, positioning, voice, tagline

## Hooks

`hooks/*.sh` are shell scripts you can wire into Claude Code via
`~/.claude/settings.json`. They are advisory: they print guidance, they don't
block.

- **design-check.sh** — UserPromptSubmit; nudges toward design-first when a
  prompt looks like "build a new X" and there's no active `designs/` dir.
- **push-review.sh** — PreToolUse on `Bash` with `git push`; reminds you to
  include an ADR when pushing non-trivial changes.
- **guide-changelog.sh** — PostToolUse on `Write|Edit` under `guides/`;
  appends to `guides/CHANGELOG.md`.
- **end-of-session.sh** — Stop hook; useful for an end-of-session audit step.

`install.sh` does NOT auto-wire hooks into `settings.json`. Wire them
yourself, or paste from your dotfiles.

## Install

```
./install.sh                     # wire skills + agents into Claude Code and Codex
./install.sh --no-codex          # Claude Code only
./install.sh --categories=coding # only coding skills (skip personal)
```

The script is idempotent. It backs up anything it replaces to
`~/.claude/backups/agent-skills-install-<timestamp>/`.

## Adding a skill

1. `mkdir skills/<category>/<skill-name>`
2. Create `SKILL.md` with the YAML frontmatter shown above.
3. Re-run `./install.sh`.

## License

MIT. See `LICENSE`.
