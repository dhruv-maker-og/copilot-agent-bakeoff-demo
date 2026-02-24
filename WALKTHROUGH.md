# 🎬 Agent Bake-Off Demo — Complete Walkthrough

> **Demo Title:** GitHub Copilot Third-Party Agent Bake-Off  
> **Duration:** ~7 minutes (pre-recorded)  
> **Audience:** Mixed (developers + leadership)  
> **Platform:** github.com  
> **Subscription Required:** Copilot Pro+ or Copilot Enterprise

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Step 0 — Enable Third-Party Agents](#step-0--enable-third-party-agents)
3. [Step 1 — Open the Repo](#step-1--open-the-repo)
4. [Step 2 — Review the Issue](#step-2--review-the-issue)
5. [Step 3 — Monitor Agent Sessions](#step-3--monitor-agent-sessions)
6. [Step 4 — Compare the 3 Draft PRs](#step-4--compare-the-3-draft-prs)
7. [Step 5 — Interact With an Agent on a PR](#step-5--interact-with-an-agent-on-a-pr)
8. [Step 6 — Show Enterprise Controls](#step-6--show-enterprise-controls)
9. [Recording Guide](#recording-guide)
10. [Narration Script](#narration-script)
11. [Troubleshooting](#troubleshooting)

---

## Prerequisites

| Requirement | Details |
|---|---|
| **Copilot subscription** | Copilot Pro+ or Copilot Enterprise |
| **Third-party agents** | Claude and Codex enabled in Copilot policies |
| **Repo** | [copilot-agent-bakeoff-demo](https://github.com/dhruv-maker-og/copilot-agent-bakeoff-demo) |
| **Issue** | [#1 — Add user preferences API endpoint with validation](https://github.com/dhruv-maker-og/copilot-agent-bakeoff-demo/issues/1) |
| **Browser** | Clean profile, no bookmarks bar, notifications off |
| **Screen recording tool** | Loom (free), OBS Studio (free), or Camtasia |

---

## Step 0 — Enable Third-Party Agents

Before agents respond to `@mentions`, they must be enabled in your Copilot settings.

### For individual accounts:

1. Go to **https://github.com/settings/copilot**
2. Scroll to the **"Policies"** section
3. Under **"Third-party coding agents"**, toggle **ON** for:
   - ✅ Claude (by Anthropic)
   - ✅ Codex (by OpenAI)
4. Copilot (GitHub) is enabled by default

### For organization/enterprise accounts:

1. Go to **https://github.com/organizations/YOUR_ORG/settings/copilot/policies**
2. Enable third-party agents at the org level
3. Individual repos inherit this setting (or can be overridden per-repo)

> 📖 Full docs: [Enabling or disabling third-party coding agents](https://docs.github.com/en/copilot/how-tos/manage-your-account/manage-policies#enabling-or-disabling-third-party-coding-agents-in-your-repositories)

---

## Step 1 — Open the Repo

**URL:** https://github.com/dhruv-maker-og/copilot-agent-bakeoff-demo

### What the audience sees:

A minimal Node.js/Express REST API with the following structure:

```
src/
├── app.js                  # Express app setup
├── server.js               # Server entry point
├── routes/
│   └── users.js            # GET /users and GET /users/:id
└── middleware/
    └── errorHandler.js     # Centralized error handler
tests/
└── users.test.js           # 5 passing Jest + Supertest tests
```

### What to click:

1. Show the repo root (file tree visible)
2. Click into **`src/routes/users.js`** — show the existing endpoint pattern (~30 lines)
3. Click back to the repo root

### Key talking point:

> *"This is a simple Express API — one resource, a few tests, nothing fancy. This is the kind of codebase you'd hand to any new developer on day one."*

---

## Step 2 — Review the Issue

**URL:** https://github.com/dhruv-maker-og/copilot-agent-bakeoff-demo/issues/1

### What the audience sees:

An issue titled **"Add user preferences API endpoint with validation"** with:

- Two new endpoints: `GET /users/:id/preferences` and `PUT /users/:id/preferences`
- Validation rules for `theme`, `language`, and `notifications`
- Error handling requirements (400, 404)
- Testing requirements
- Acceptance criteria checklist

### What to click:

1. Read through the issue requirements (scroll slowly for the camera)
2. Scroll to the bottom to show **three comments**:
   - `@copilot implement this issue...`
   - `@claude implement this issue...`
   - `@codex implement this issue...`

### Key talking point:

> *"I gave the exact same task to three different AI agents — Copilot, Claude, and Codex — at the same time. Each one reads the repo, understands the requirements, and works on it independently. Let's see what happened."*

---

## Step 3 — Monitor Agent Sessions

**URL:** https://github.com/dhruv-maker-og/copilot-agent-bakeoff-demo/agents

*(Or click the **"Agents"** tab in the repo navigation bar)*

### What the audience sees:

- A dashboard showing all agent sessions for this repo
- Each session displays: agent name, linked issue, status (running/completed), duration
- Each completed session links to a draft Pull Request

### What to click:

1. Show the list of 3 completed sessions
2. **Click into one session** (e.g., Claude) to show the execution log:
   - What files the agent read
   - What it planned to do
   - What code it wrote
   - What tests it ran
3. Click back to the Agents tab

### Key talking points:

> *"This is the Agents tab — think of it as a dashboard for every AI agent session in your repo."*

> *"Full transparency: you can see every step the agent took, just like reviewing a teammate's work. This is your audit trail."*

---

## Step 4 — Compare the 3 Draft PRs

**URL:** https://github.com/dhruv-maker-og/copilot-agent-bakeoff-demo/pulls

Open each PR and navigate to the **"Files changed"** tab. Spend ~1 minute on each.

### What to compare:

| Dimension | What to look for |
|---|---|
| **Validation approach** | Inline checks vs. separate validator module vs. JSON Schema/library |
| **Error message format** | Simple strings vs. structured JSON with field-level errors |
| **Test count & depth** | Number of test cases, edge cases covered |
| **Default preferences** | Does the agent set defaults for new users? |
| **Code organization** | New files added? Naming conventions followed? |
| **One unique decision** | Something only this agent did differently |

### PR #1 — Copilot

> *"Copilot stayed close to our existing patterns — validation is inline, similar to what we already have in users.js. Clean, minimal, easy to review."*

### PR #2 — Claude

> *"Claude went further — notice it created a separate validation utility. And look at the test count: more test cases including edge cases like empty strings and invalid language codes. More thorough, but more files touched."*

### PR #3 — Codex

> *"Codex took [describe its approach]. Interesting that it [highlight one unique choice]."*

### Key talking point:

> *"Three agents, same task, three different solutions. You'd normally need three senior engineers and a meeting to get this diversity of perspective. Here it took ten minutes and zero meetings."*

---

## Step 5 — Interact With an Agent on a PR

Pick one of the 3 PRs (ideally the one with the most room for improvement).

### What to do:

1. Navigate to the PR's **Conversation** tab
2. Scroll to the comment box at the bottom
3. Type one of these comments:

**Option A — Request a feature addition:**
```
@copilot can you also add rate limiting to this endpoint?
```

**Option B — Request a review from a different agent:**
```
@claude can you review this PR for security issues?
```

**Option C — Request follow-up work:**
```
@codex can you add a DELETE /users/:id/preferences endpoint to reset preferences?
```

4. Submit the comment
5. (If pre-recording: show the agent's response/commit that comes later)

### Key talking point:

> *"Agents aren't one-shot. I just asked Claude to add rate limiting — right here in the PR. It'll read the context, understand the existing code, and push a new commit. No copy-pasting, no switching tools. Everything stays in GitHub."*

---

## Step 6 — Show Enterprise Controls

*(Optional — 15-30 seconds for leadership audience)*

### What to show:

1. **Copilot Policies:** https://github.com/settings/copilot → show agent enable/disable toggles
2. **Audit Logs:** *(org admin only)* https://github.com/organizations/YOUR_ORG/settings/audit-log → filter by `copilot`
3. **Metrics Dashboard:** *(if available)* Copilot usage metrics across the organization

### Key talking point:

> *"For teams and enterprises: you control which agents are allowed at the org level. Full audit logs, usage metrics, and code quality checks — all built in. No new tools, no new dashboards."*

---

## Recording Guide

### Setup

| Setting | Recommendation |
|---|---|
| **Resolution** | 1920×1080 |
| **Browser zoom** | 110% (makes text legible on screen) |
| **GitHub theme** | Dark mode (Settings → Appearance) — higher contrast on recording |
| **Browser profile** | Clean — no bookmarks bar, no personal tabs |
| **Notifications** | Turn off OS and browser notifications |
| **Mouse highlighter** | Use a cursor highlight extension so viewers can follow clicks |

### Pre-load these browser tabs (left to right):

1. Repo homepage: `https://github.com/dhruv-maker-og/copilot-agent-bakeoff-demo`
2. `src/routes/users.js` file view
3. Issue #1: `https://github.com/dhruv-maker-og/copilot-agent-bakeoff-demo/issues/1`
4. Agents tab: `https://github.com/dhruv-maker-og/copilot-agent-bakeoff-demo/agents`
5. PR #1 (Copilot) → Files changed tab
6. PR #2 (Claude) → Files changed tab
7. PR #3 (Codex) → Files changed tab
8. Copilot Policies settings page

### Scene-by-scene recording plan:

| Scene | Tab | Content | Duration |
|---|---|---|---|
| 1 | Tabs 1-2 | Repo homepage → click into `users.js` → back | 60s |
| 2 | Tab 3 | Issue #1 → scroll requirements → show 3 agent mentions | 60s |
| 3 | Tab 4 | Agents tab → click into one session → show log | 60s |
| 4 | Tab 5 | PR #1 (Copilot) — Files Changed → highlight approach | 60s |
| 5 | Tab 6 | PR #2 (Claude) — Files Changed → highlight differences | 60s |
| 6 | Tab 7 | PR #3 (Codex) — Files Changed → highlight unique choices | 60s |
| 7 | Tab 5/6/7 | Pick one PR → type `@agent` comment → submit | 45s |
| 8 | Tab 8 | Flash enterprise controls | 15s |

**Total: ~7 minutes**

### Post-production:

1. Stitch scenes together with ~0.5s fade transitions
2. Add a **title card** at the start: *"GitHub Copilot: Third-Party Agent Bake-Off"*
3. Add **lower-third labels** when switching PRs: *"Agent: Copilot"*, *"Agent: Claude"*, *"Agent: Codex"*
4. Add an **end card**: *"Try it → github.com/copilot/agents"*
5. Export at **1080p, MP4 format**

---

## Narration Script

### Scene 1 — The Repo (0:00 – 1:00)

> *"Here's a simple Node and Express API. It has one endpoint — GET /users — with a few tests. Nothing fancy. This is the kind of codebase you'd hand to a new developer on day one.*
>
> *Now, what if I could hand the same task to three different AI agents — Copilot, Claude, and Codex — and compare how they approach it? That's exactly what we're going to do."*

### Scene 2 — The Issue (1:00 – 2:00)

> *"I created this issue: 'Add a user preferences endpoint with validation.' It asks for GET and PUT endpoints, input validation for fields like theme, language, and notifications, proper error handling, and tests.*
>
> *Then I did something you normally can't do — I assigned the same task to three different agents at the same time. At Copilot, at Claude, at Codex. Each one picked it up and worked on it independently. Let's see what happened."*

### Scene 3 — The Agents Tab (2:00 – 3:00)

> *"This is the Agents tab — it's like a dashboard for every agent session in your repo. You can see all three sessions completed. Each one shows what the agent read, what it planned, and what it wrote.*
>
> *Here's Claude's session log. It read the existing code, understood the patterns, planned its approach, then wrote the implementation and tests. Full transparency — same traceability you'd expect from any teammate.*
>
> *And notice — every session has a linked pull request. Let's compare them."*

### Scene 4 — PR #1: Copilot (3:00 – 4:00)

> *"First up, Copilot. It stayed close to our existing patterns — the validation is inline, similar to what we already have in users.js. Clean, minimal, and easy to review.*
>
> *It added [X] tests covering the basic success and error cases. Straightforward — this is the 'get it done' approach."*

### Scene 5 — PR #2: Claude (4:00 – 5:00)

> *"Now Claude. Notice it went further — it created a separate validation utility. This is a design choice: reusable validation instead of inline checks.*
>
> *And look at the tests — [Y] test cases, including edge cases like empty strings, invalid language codes, and missing fields. More thorough, more opinionated. Whether that's better depends on your team's preferences — and that's exactly the point."*

### Scene 6 — PR #3: Codex (5:00 – 6:00)

> *"Finally, Codex. [Describe its approach]. Interesting that it [highlight one standout decision].*
>
> *Three agents, same task, three different solutions. You'd normally need three senior engineers and a meeting to get this diversity of perspective. Here it took ten minutes and zero meetings."*

### Scene 7 — Live Interaction (6:00 – 6:45)

> *"But it doesn't stop at the first draft. I can talk to any agent right in the pull request.*
>
> *I just asked [agent] to [describe the request] — directly in the PR comment. It'll read the context, understand the existing code, and push a new commit. No copy-pasting, no switching tools. Everything stays in GitHub."*

### Scene 8 — Enterprise Controls & Close (6:45 – 7:15)

> *"For teams and enterprises: you control which agents are allowed, at the org level. Full audit logs, usage metrics, and code quality checks — all built in.*
>
> *Third-party agents on GitHub let you move from idea to implementation using different agents for different strengths — without leaving the platform your code already lives on."*

---

## Troubleshooting

| Problem | Solution |
|---|---|
| Agents didn't respond to `@mentions` | Verify agents are enabled in Copilot policies (Step 0). Try assigning the issue to Copilot via the sidebar "Assignees" dropdown instead. |
| No "Agents" tab in repo navigation | Feature may need org-level enablement or requires Copilot Enterprise. Check [GitHub docs](https://docs.github.com/en/copilot/how-tos/manage-your-account/manage-policies). |
| Agent session failed or errored | Check the session log in the Agents tab. Re-trigger by posting a new `@agent` comment on the issue. |
| Only Copilot works, not Claude/Codex | Claude and Codex must be **explicitly** enabled in policies — they are off by default. |
| Agent is taking too long | Agent sessions typically take 5–15 minutes. For the pre-recorded demo, trigger agents well ahead of time and record after all 3 PRs are ready. |
| Comments show `@copilot` as plain text (not linked) | The Copilot GitHub app may not be installed on the repo. Check repo Settings → Integrations. |

---

## Useful Links

| Resource | URL |
|---|---|
| Demo Repo | https://github.com/dhruv-maker-og/copilot-agent-bakeoff-demo |
| Issue #1 | https://github.com/dhruv-maker-og/copilot-agent-bakeoff-demo/issues/1 |
| Copilot Policies | https://github.com/settings/copilot |
| Third-Party Agents Docs (VS Code) | https://code.visualstudio.com/docs/copilot/agents/third-party-agents |
| Agent HQ Blog Post | https://github.blog/news-insights/company-news/pick-your-agent-use-claude-and-codex-on-agent-hq/ |
| Enable Third-Party Agents | https://docs.github.com/en/copilot/how-tos/manage-your-account/manage-policies#enabling-or-disabling-third-party-coding-agents-in-your-repositories |
| GitHub Copilot Billing | https://docs.github.com/en/copilot/concepts/billing/copilot-requests |

---

## Checklist (Before Recording)

- [ ] Third-party agents enabled in Copilot policies
- [ ] Repo is public and accessible
- [ ] Issue #1 exists with all 3 `@agent` comments posted
- [ ] All 3 agents have completed and produced draft PRs
- [ ] Reviewed all 3 PRs — noted key differences for narration
- [ ] 8 browser tabs pre-loaded in order
- [ ] Screen recording tool tested (audio, resolution, no notifications)
- [ ] Dry run of narration timed at ~7 minutes
- [ ] Recording completed and edited
- [ ] Final video exported at 1080p MP4
