#!/usr/bin/env bash
#
# push-review.sh — PreToolUse hook, matcher: Bash with `git push` command.
#
# Advisory only. If the user is about to push commits that touch designs/,
# src/, or other significant paths without an ADR in the push, print a
# gentle reminder. Does not block.

set -eu

# The hook receives JSON on stdin with the proposed tool call.
read_command() {
	python3 -c 'import json,sys; d=json.load(sys.stdin); print(d.get("tool_input",{}).get("command",""))' 2>/dev/null || true
}

cmd="$(read_command)"
[[ -z "$cmd" ]] && exit 0

# Only advise on `git push` — and only when pushing something meaningful.
# Skip pushes of tags, branches without commits, or explicit force-pushes
# (those have their own review via the main permission layer).
case "$cmd" in
	*"git push"*) ;;
	*) exit 0 ;;
esac

# Find the repo root from cwd; bail quietly if not in a git checkout.
repo="$(git rev-parse --show-toplevel 2>/dev/null)" || exit 0
cd "$repo" || exit 0

# Grab commits being pushed: local commits ahead of origin/<current branch>.
branch="$(git symbolic-ref --short HEAD 2>/dev/null)" || exit 0
ahead_range="@{u}..HEAD"
ahead_count="$(git rev-list --count "$ahead_range" 2>/dev/null || echo 0)"
[[ "$ahead_count" == "0" ]] && exit 0

# Look at the changed files in the pending commits.
changed="$(git diff --name-only "$ahead_range" 2>/dev/null || true)"
[[ -z "$changed" ]] && exit 0

# Only flag when meaningful paths change and no ADR is included.
touches_src() {
	printf '%s\n' "$changed" | grep -Eq '^(src/|cmd/|pkg/|internal/|designs/)'
}
has_adr() {
	printf '%s\n' "$changed" | grep -Eq 'adrs?/.*\.md$'
}

if touches_src && ! has_adr; then
	cat <<EOF

Reminder: pushing $ahead_count commit(s) on branch '$branch' that touch
src/designs paths with no ADR in the change set.

If this change made a non-trivial decision (architecture, dependency,
contract), consider adding an ADR under designs/<project>/adrs/ before
pushing. See agent/guides/work/design-docs.md.

This is advisory; push will proceed unless you cancel.
EOF
fi

exit 0
