# What was measured

All of this is from 16 November 2026, on my own work, with me writing both the rule and the tests. It is a small sample.

## The weighing rule

A fresh Opus 5.5 session gets a list of tasks and says small or large for each. It runs nothing. I read whether I agree.

| Rule | Delivered by | Tasks | Agreed |
|---|---|---|---|
| Dutch (`rules/weigh.nl.md`) | `CLAUDE.md` | 4 from my own work: 3 small, 1 large | 4 of 4 |
| English (`rules/weigh.md`) | the plugin's session hook | the 4 in `test/tasks.example.txt`: 3 small, 1 large | 4 of 4 |

A control session without the rule and without the plugin answered `RULE_VISIBLE: no`.

In both tests the session was asked to apply the rule. Separately, a normal session in another project opened with its 1-line verdict without being asked, and switched to large when I typed the word.

On the large task both English runs added a caveat: the rule didn't define "independent". Since 0.2.1 it does: parts that different workers could build at the same time. The English rule was tested twice, once loaded with `--plugin-dir` and once installed from the marketplace, with the same 4 of 4.

## One real run

A design job of 8 screens.

- 3 questions in 1 round, including the ambition question. The upgrade was picked.
- Fable planned 9 steps.
- 7 Opus workers built: 1 for the shared components, then 6 at the same time.
- The main session checked each screen itself and fixed 3 mismatches between screens.
- The fresh Fable review found nothing wrong with how the screens were built, and 12 places where text or numbers contradicted each other. 2 of those were in the spec.
- 1 Opus worker fixed the 12 points, 1 Sonnet worker did exports and docs.

## What went wrong

- 1 check was not measured. The mobile screens had a width check, the worker reported it couldn't measure widths, and the main session approved the task on a screenshot. The skill says the conductor runs the check itself.
- Subagents are expensive in a project with a long `CLAUDE.md`. One that answered a single question without using a tool used 107,584 tokens; that project's `CLAUDE.md` is 143,084 characters.

## Not measured

- What this does to usage limits compared with running everything on Fable.
- Whether a Haiku worker is good enough for its row in the table. The real run used none.
- Any second run. 1 run is 1 run.
