---
name: dirigent
description: "Use when a task is weighed as large under the task-weighing rule ('Weigh the task' / 'Taak wegen', from this plugin's session hook or the user's CLAUDE.md: will not fit one session, has three or more independent parts, or spans several subsystems or repos), when the user types /dirigent or says 'large' or 'groot', or when an /ambition brief has just been picked and must now be carried out."
---

# Dirigent

Run a large task as a conductor: Fable plans and reviews, cheaper models build, the user answers every question once at the start and then reads one report.

You (the main session) stay the conductor for the whole task. Subagents cannot be relied on to start their own workers, so you dispatch every worker yourself.

## Steps

Do these in order. Use the task tool for the task list so progress stays visible.

### 1. Announce

One line, in the user's language: `Large: Fable plans, workers build, Fable reviews.`

### 2. Read first, then one question round

Read the code, CLAUDE.md, memory and brain documents the task touches. Then ask the user everything in ONE AskUserQuestion call (at most 4 questions), in the user's language:

- Only questions the material does not answer and whose answer changes the plan.
- Give a recommended option first for each.
- The last question is always: "Is there anything I should know that isn't written down anywhere?" (domain knowledge, a customer promise, something tried before).

**Ambition question.** One of the (at most 4) questions offers a single upgrade. Find it the way the `ambition` skill does (if it is installed, use its Think steps; do not print its output contract): ask what should happen after this task is done, what a field-leading professional would do that was not asked, and which other field does the same verbs. Keep the one deeper version of the task with the best payoff for its cost, and its judge. Ask it as:

- Question: "Do you want to raise the bar?"
- Option 1: "No, just the task"
- Option 2: the upgrade in one sentence, with its extra cost and its judge.

If the user picks the upgrade, it becomes part of the task and goes into the plan with its judge. If not, do not build any part of it. If you find no upgrade that raises the outcome and has an outside judge, leave this question out.

If an /ambition brief is the input, its "Needs from you" answers count as this round; ask only what is still open, plus the last question, and leave the ambition question out (the user already chose).

After this round, work without further questions. The exceptions are in "What stays with the user".

### 3. Plan (Fable)

Start one subagent with `model: "fable"` (skip the subagent if the session itself already runs on Fable; plan inline). Give it the task, the user's answers, and pointers to the files and docs worth reading. Ask it to return:

| Task | Depends on | Worker model | Skill or agent type | Judge |
|---|---|---|---|---|

- **Judge** = something other than a model's opinion whose output decides pass or fail: a test that fails first, a build, a metric, a before/after run on the same data, a diff against a reference. Who reads it and the pass line. A task without a judge is not ready to hand out; split or rewrite it.
- **Worker model**: see the table below.
- Mark which tasks can run at the same time.

Show the user the plan as that table, then continue. The user can interrupt to change it; do not wait for approval unless the plan contains something from "What stays with the user".

### 4. Build (workers)

Dispatch workers yourself, independent tasks in one message so they run at once. Each brief stands alone: goal, files, the rules from CLAUDE.md that apply, the judge and its pass line, and what to return (what changed, the judge's actual output).

| Work | Model |
|---|---|
| Search, list files, read logs | haiku |
| Clear and bounded: a doc, a rename, a test for specified behaviour, boilerplate | sonnet |
| Default: implementation, debugging, anything needing judgment | opus |
| The one hardest part, only when Opus failed its judge twice | fable |

Use an existing agent type or skill when one fits the task (its own model setting then applies). Code workers on the same repo get `isolation: "worktree"`.

A subagent costs a full context of its own. Start one only for work that runs in parallel or would flood your context; a handful of tool calls you do yourself.

### 5. Check each result

Run or read the judge yourself; a worker's "done" is a claim, not a result. Fail → send the same worker back with the judge's output (SendMessage), at most twice, then escalate the model one step.

### 6. Review (fresh Fable)

One subagent with `model: "fable"` that gets the diff and the original task, not the plan, not the workers' reports, not your conclusions. Ask for defects ranked by severity, each with a concrete failing scenario. Fix confirmed defects through a worker, re-run the affected judges.

### 7. Report

Written for someone who saw none of the work, in the user's language:

1. First line: what works now and how to see it.
2. Judge results per task: target next to measured result, misses included.
3. Every change made, small ones too.
4. What needs a decision from the user, each with a recommendation.

## What stays with the user

Workers never do these, and you do them only after the user says yes to that specific action: deploys, DDL or data changes on production, flags on the live fleet, merges to main, messages to customers or other people, anything that cannot be undone. Put them in the plan as "waits for you" steps and in the report as open decisions. Keep going on everything that does not depend on them.

## When not to use

The task fits one session and has no independent parts: do it directly. On a small task this setup costs more than it saves, because the conductor reads everything again to check it.
