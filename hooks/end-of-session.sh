#!/usr/bin/env bash
#
# end-of-session.sh — Stop hook.
#
# Runs a quiet `bin/dotfiles audit` at session end so drift is visible. If
# audit is silent (no drift), this hook produces no output. If audit finds
# issues, the summary is printed to the session. Always exits 0.

set -eu

# Derive dotfiles root from the script's location so we don't depend on
# $DOTFILES being set in the hook environment (launchd/Claude hooks don't
# always inherit shell exports).
self="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
script="$self/bin/dotfiles"

[[ -x "$script" ]] || exit 0

output="$("$script" audit 2>&1 || true)"

# Only show output if there's drift worth showing. "no drift" means quiet.
if printf '%s' "$output" | grep -q 'no drift'; then
	exit 0
fi

cat <<EOF

--- dotfiles audit at session end ---
$output
--- end ---
EOF

exit 0
