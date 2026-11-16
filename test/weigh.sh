#!/usr/bin/env bash
# Ask a fresh Opus session to weigh your own tasks with the rule that is live in your setup.
# Usage: bash test/weigh.sh [tasks.txt]   (one task per line; default: test/tasks.example.txt)
# Nothing is executed: the session only says small or large per task. You read whether you agree.
set -euo pipefail
tasks="${1:-$(dirname "$0")/tasks.example.txt}"
[ -f "$tasks" ] || { echo "no such file: $tasks" >&2; exit 1; }
prompt="This is a wording test of a rule. Do NOT carry out any task below and use no tools.

First line of your answer: 'RULE_VISIBLE: yes' or 'RULE_VISIBLE: no' (whether a task-weighing rule, 'Weigh the task: small or large' or 'Taak wegen', is in your context). If no, stop there.

Then for each numbered task apply that rule exactly as written and give: the number, the one line the rule tells you to say, and in at most 12 words which criterion decided it. If the rule leaves a case unclear, say UNCLEAR and what is missing from the wording.

$(nl -w1 -s'. ' "$tasks")"
claude -p --model opus "$prompt" < /dev/null
