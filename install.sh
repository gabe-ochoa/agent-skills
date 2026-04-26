#!/usr/bin/env bash
#
# install.sh
#
# Wire skills/, agents/, hooks/, and guides/ into the paths Claude Code and
# Codex expect.
#
# One source tree, organized for humans by category (personal/coding/...),
# flattened on install to whatever each agent expects:
#
#   skills/<category>/<skill-name>/SKILL.md  ->  ~/.claude/skills/<skill-name>
#                                                ~/.codex/skills/<skill-name>
#   agents/<name>.md                          ->  ~/.claude/agents/<name>.md
#
# Idempotent: backs up any file it replaces into
# ~/.claude/backups/agent-skills-install-<timestamp>/ before swapping in a
# symlink.
#
# Flags:
#   --no-codex   Skip Codex (~/.codex) wiring. Claude Code only.
#   --categories a,b,c
#                Limit which skills/<category> dirs are wired. Default: all.
#                Useful if you fork this repo and add private categories you
#                want gated by a flag.
#
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="$HOME/.claude/backups/agent-skills-install-$STAMP"

codex=1
categories=""
for arg in "$@"; do
  case "$arg" in
    --no-codex)        codex=0 ;;
    --categories=*)    categories="${arg#--categories=}" ;;
    *) echo "unknown flag: $arg" >&2; exit 2 ;;
  esac
done

log()  { printf '\033[1;34m[agent-skills]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[agent-skills]\033[0m %s\n' "$*" >&2; }

ensure_real_dir() {
  local dest="$1"
  if [[ -L "$dest" ]]; then
    mkdir -p "$BACKUP"
    local current
    current="$(readlink "$dest")"
    log "replacing symlink $dest (was -> $current) with real directory"
    mv "$dest" "$BACKUP/$(basename "$dest").symlink"
  fi
  mkdir -p "$dest"
}

backup_and_replace() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [[ -L "$dest" ]]; then
    local current
    current="$(readlink "$dest")"
    if [[ "$current" == "$src" ]]; then
      return 0
    fi
    log "replacing stale symlink $dest (was -> $current)"
    rm "$dest"
  elif [[ -e "$dest" ]]; then
    mkdir -p "$BACKUP"
    log "backing up $dest -> $BACKUP/"
    mv "$dest" "$BACKUP/"
  fi
  ln -s "$src" "$dest"
  log "linked $dest -> $src"
}

# Resolve list of categories to wire.
resolve_categories() {
  if [[ -n "$categories" ]]; then
    echo "$categories" | tr ',' '\n'
    return
  fi
  for d in "$REPO/skills"/*/; do
    [[ -d "$d" ]] || continue
    basename "$d"
  done
}

wire_skills_into() {
  local target_dir="$1"
  ensure_real_dir "$target_dir"
  while IFS= read -r category; do
    [[ -n "$category" ]] || continue
    local dir="$REPO/skills/$category"
    [[ -d "$dir" ]] || { warn "category not found: $category"; continue; }
    for skill_dir in "$dir"/*/; do
      [[ -d "$skill_dir" ]] || continue
      local name
      name="$(basename "$skill_dir")"
      backup_and_replace "${skill_dir%/}" "$target_dir/$name"
    done
  done < <(resolve_categories)
}

# --- Claude Code: skills ----------------------------------------------------

log "Claude Code: skills/"
wire_skills_into "$HOME/.claude/skills"

# --- Claude Code: agents ----------------------------------------------------

if [[ -d "$REPO/agents" ]]; then
  log "Claude Code: agents/"
  ensure_real_dir "$HOME/.claude/agents"
  for f in "$REPO/agents"/*.md; do
    [[ -f "$f" ]] || continue
    backup_and_replace "$f" "$HOME/.claude/agents/$(basename "$f")"
  done
fi

# --- Codex: skills ----------------------------------------------------------

if [[ "$codex" == "1" ]]; then
  log "Codex: skills/"
  wire_skills_into "$HOME/.codex/skills"
fi

# --- Hooks: not auto-wired --------------------------------------------------

if [[ -d "$REPO/hooks" ]]; then
  log "hooks/ available at $REPO/hooks (wire via your settings.json)"
fi

if [[ -d "$BACKUP" ]]; then
  log "done. backups at $BACKUP"
else
  log "done. no backups needed."
fi
