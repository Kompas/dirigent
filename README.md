# dirigent

A Claude Code skill that runs a large task the way a conductor would. Fable 5.2 plans and reviews, cheaper models build, and you answer every question once at the start.

Opus 5.5 stays the default model in every session. A rule in `CLAUDE.md` makes it weigh each task as small or large and say so in 1 line. A small task it does itself. A large task loads this skill:

1. One question round up front, 4 questions at most. One of them offers a single upgrade from the [ambition](https://github.com/Kompas/ambition) skill if you have it, the last one asks for knowledge that isn't written down anywhere.
2. A Fable subagent writes the plan as a table, with a worker model and a pass or fail judge per task.
3. Workers build in parallel on Haiku, Sonnet or Opus.
4. The main session runs each judge itself.
5. A fresh Fable subagent reviews the result without seeing the plan.
6. One report at the end.

Deploys, production data, merges and messages to people wait for your yes.

## Install

1. Copy `SKILL.md` to `~/.claude/skills/dirigent/SKILL.md`.
2. Paste `CLAUDE-block.md` at the end of `~/.claude/CLAUDE.md`. This is the weighing rule; without it nothing loads the skill on its own. `CLAUDE-block.nl.md` is the Dutch version I run myself.
3. Set the default model to Opus in `~/.claude/settings.json` (`"model": "opus"`). I keep effort on `high`.
4. Start a new session. A running session keeps the `CLAUDE.md` it started with.

You can always force it with `/dirigent`, or flip the weighing with one word: small, large or fable.

## What I measured

- The weighing rule (the Dutch version), in a fresh Opus session, on 4 tasks from my own work: 3 small, 1 large, and I agreed with all 4.
- 1 real run, a design job of 8 screens: 3 questions in 1 round, 1 Fable plan of 9 steps, 7 Opus workers of which 6 ran at the same time. The main session caught 3 mismatches between screens. The Fable review then found 12 places where text or numbers contradicted each other, 2 of them in the spec.
- In that run 1 judge was not measured (a width check the worker could not run) and the task was approved on a screenshot anyway.
- A subagent that answered 1 question without using a tool used 107,584 tokens in a project whose `CLAUDE.md` is 143,084 characters. Subagents are not cheap.

The English `CLAUDE-block.md` is a translation and has not been tested separately.

The idea of Fable as lead and cheaper models as workers comes from Anthropic's guidance for Fable 5.2, which I picked up from [this AI LABS video](https://youtu.be/EFGvVCpW9zc).

MIT licensed.
