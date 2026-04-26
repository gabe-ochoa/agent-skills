#!/usr/bin/env bash
#
# guide-changelog.sh — PostToolUse hook, matcher: Write|Edit on files under
# agent/guides/.
#
# Appends a one-line entry to agent/guides/CHANGELOG.md whenever a guide is
# modified, so we have a running history without relying on git log alone.
# Pulls the changed file path from the tool_input JSON on stdin.

set -eu

read_path() {
	python3 -c '
import json, sys
d = json.load(sys.stdin)
t = d.get("tool_input", {})
print(t.get("file_path", ""))
' 2>/dev/null || true
}

path="$(read_path)"
[[ -z "$path" ]] && exit 0

# Only fire for guides under the dotfiles agent tree.
case "$path" in
	*"/dotfiles/agent/guides/"*) ;;
	*) exit 0 ;;
esac

repo_root="${path%/agent/guides/*}"
changelog="$repo_root/agent/guides/CHANGELOG.md"
rel="${path#$repo_root/}"

# Create the changelog file if it doesn't exist.
if [[ ! -f "$changelog" ]]; then
	cat >"$changelog" <<'EOF'
# Guide Changelog

Auto-appended by `agent/hooks/guide-changelog.sh` whenever any file under
`agent/guides/` is modified. Keep chronological; newest entries at the top.

EOF
fi

# Prepend a one-line entry.
tmp="$(mktemp)"
{
	head -5 "$changelog"
	printf -- '- %s  %s\n' "$(date +%Y-%m-%d)" "$rel"
	tail -n +6 "$changelog"
} >"$tmp"
mv "$tmp" "$changelog"

exit 0
