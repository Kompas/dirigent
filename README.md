# dirigent

A Claude Code plugin that lets Opus decide how big a task is. A small task it does itself. A large one gets Fable 5.2 as planner and reviewer, cheaper models as workers, and all the questions in 1 round at the start.

Dirigent is Dutch for conductor.

## What it looks like

You type a task in any session. The first line back is one of these.

```
Small: I'll do it myself.
```

```
Large: Fable plans, workers build, Fable reviews.
```

After `Large` you get 1 round of questions. These are from a real run, a design job of 8 screens, translated and shortened:

```
1. Which name does the team get by default?
   Crew (recommended) · On Call · Night Watch · Guard

2. Do you want to raise the bar?
   No, just the task · Also the night on mobile (+45 min, judge: nothing runs off a 390 px screen)

3. Is there anything I should know that isn't written down anywhere?
   No, go on · Yes, see my note
```

Then it ran without asking anything else:

1. Fable planned 9 steps.
2. 1 Opus worker built the shared components.
3. 6 Opus workers built 1 screen each, at the same time.
4. Opus checked every screen itself and fixed 3 things that didn't match between screens.
5. A fresh Fable agent reviewed all 8 screens and found 12 places where text or numbers contradicted each other.
6. An Opus worker fixed those, a Sonnet worker did the exports and the docs.
7. One report at the end.

## Install

```bash
claude plugin install dirigent --marketplace Kompas/ribbon
```

Then make Opus your default model. Type `/model opus` in a session; that also saves it for new sessions. Start a new session and give it a task.

The plugin has 2 parts. The skill does the conducting. A session hook adds the weighing rule ([`rules/weigh.md`](rules/weigh.md)) to every new session, so nothing is written to your `CLAUDE.md`. Uninstalling the plugin removes both.

You need access to Fable 5.2 and Opus 5.5 in Claude Code.

### Try it without the plugin

```bash
mkdir -p ~/.claude/skills/dirigent
curl -fsSL https://raw.githubusercontent.com/Kompas/dirigent/main/SKILL.md -o ~/.claude/skills/dirigent/SKILL.md
```

Now `/dirigent <task>` runs one task this way. Nothing weighs your tasks for you until you also paste `rules/weigh.md` into your `CLAUDE.md`. A Dutch version of the rule is in [`rules/weigh.nl.md`](rules/weigh.nl.md).

## Staying in control

- One word flips the weighing: `small`, `large`, or `fable` (this part goes to a Fable subagent).
- You see the plan before the workers start and can change it.
- Deploys, production data, merges and messages to people wait for your yes. Workers never do them.
- With the [ambition](https://github.com/Kompas/ambition) skill installed, the question round offers 1 upgrade. "No, just the task" is always the first option.

## Which model does what

| Work | Model |
|---|---|
| Weighing, handing out work, checking each result | Opus (your session) |
| The plan, and the review at the end | Fable |
| Search, list files, read logs | Haiku |
| Clear and bounded: a doc, a rename, a test for specified behaviour | Sonnet |
| Implementation, debugging, anything needing judgment | Opus |
| The one hardest part, after Opus failed its check twice | Fable |

## What it costs

A subagent starts with a full context of its own. In one of my projects a subagent that answered 1 question without using a tool used 107,584 tokens, because that project's `CLAUDE.md` is 143,084 characters. The skill only starts a worker for work that runs in parallel, and a small task never reaches it.

## Test the rule on your own tasks

```bash
git clone https://github.com/Kompas/dirigent && cd dirigent
bash test/weigh.sh my-tasks.txt
```

Put one task per line in the file. A fresh Opus session says small or large for each and names the criterion. Nothing is executed. You read whether you agree. If you don't, the rule is 18 lines of text and you can edit it.

What I measured, and what I didn't, is in [`RESULTS.md`](RESULTS.md).

## Credits and license

Fable as lead with cheaper models as workers is Anthropic's own advice for Fable 5.2. I picked it up from [this AI LABS video](https://youtu.be/EFGvVCpW9zc). The judge per task comes from [ambition](https://github.com/Kompas/ambition), which builds on Felix Rieseberg and Nick Beaird.

This plugin: Tim Hagebols. MIT, see [LICENSE](LICENSE).
