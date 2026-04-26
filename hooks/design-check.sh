#!/usr/bin/env bash
#
# design-check.sh — UserPromptSubmit hook.
#
# If the user's prompt looks like "build/implement/start X" and the current
# working directory has no recent `designs/` activity, print a gentle
# reminder that the design-first workflow is the default.
#
# Hook contract: receives the prompt JSON on stdin. Prints advisory output
# to stdout (Claude sees it as context). Exits 0 always — never blocks.

set -eu

# Claude Code passes hook input as JSON on stdin. We only need the prompt
# field; avoid a jq dependency by using a tiny python one-liner.
read_prompt() {
	python3 -c 'import json,sys; d=json.load(sys.stdin); print(d.get("prompt",""))' 2>/dev/null || true
}

prompt="$(read_prompt)"
[[ -z "$prompt" ]] && exit 0

# Look for the "I want to build something new" pattern. Conservative: only
# fires when the prompt has BOTH an action verb and a build-target noun
# within the same prompt. False positives are worse than false negatives.
verb='\b(build|implement|create|design|start|make)\b'
target='\b(service|system|feature|api|tool|library|pipeline|migration|microservice|daemon|backend|frontend)\b'
if printf '%s' "$prompt" | grep -Eqi "$verb" && \
   printf '%s' "$prompt" | grep -Eqi "$target"; then
	cwd="$(pwd)"
	designs_dir="$cwd/designs"
	recent=0
	if [[ -d "$designs_dir" ]]; then
		# Anything modified under designs/ in the last 7 days counts.
		if find "$designs_dir" -type f -mtime -7 2>/dev/null | grep -q .; then
			recent=1
		fi
	fi

	if [[ "$recent" == "0" ]]; then
		cat <<'EOF'

Reminder: design-first workflow. Before writing code for
a new service/feature/system, produce the design package (press release,
requirements, exec brief, design doc, ADRs) and convene the Expert Review
Board. Run `/design-start <project>` if you haven't already scaffolded.

Override: if this is a trivial change, a bug fix, or otherwise not a new
system, continue as usual.
EOF
	fi
fi

exit 0
