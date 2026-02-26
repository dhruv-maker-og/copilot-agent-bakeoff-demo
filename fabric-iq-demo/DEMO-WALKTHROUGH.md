# Customer 360 Demo — Video Recording Walkthrough

> **Duration:** 5-7 minutes | **Audience:** Technical decision makers + developers | **Format:** Pre-recorded video

This is your step-by-step guide for recording the demo. Follow it scene by scene.

---

## Pre-Recording Checklist

### Environment Setup
- [ ] **Fabric SQL Database** created with all tables, data, and views loaded
  - Run `data/01-create-tables.sql`
  - Run `data/02-seed-data.sql`
  - Run `data/03-create-views.sql`
- [ ] **Fabric IQ Ontology** created with all entity types, relationships, and data bindings
  - Follow `ontology/ontology-setup-guide.md`
- [ ] **Data Agent** created and connected to the ontology
- [ ] **VS Code** open with:
  - MSSQL extension connected to Fabric SQL Database (connection confirmed)
  - GitHub Copilot active (icon visible in status bar)
  - `copilot-demo/demo-queries.sql` ready to open
  - Dark theme, clean layout, font size 16+ for recording
- [ ] **Fabric portal** open in browser with:
  - Tab 1: Ontology graph preview
  - Tab 2: Data Agent chat

### Screen / Recording Setup
- [ ] Resolution: 1920x1080 or higher
- [ ] Close all notifications, Slack, Teams, email
- [ ] Hide bookmarks bar in browser
- [ ] Disable Windows notifications (Focus Assist → ON)
- [ ] Test microphone levels
- [ ] Prepare a glass of water

---

## Scene-by-Scene Script

---

### SCENE 1: Title Card (10 seconds)

**Screen:** Architecture diagram overlay (use `assets/architecture-diagram.md` — Main Architecture diagram)

**Voiceover:**
> "Today we'll see how Microsoft Fabric IQ and GitHub Copilot work together to deliver a Customer 360 experience in financial services — bridging the gap between developers and business analysts with a shared semantic foundation."

---

### SCENE 2: VS Code — Copilot Warm-up (45-60 seconds)

**Screen:** VS Code (full screen), MSSQL extension connected, empty SQL file open

**Action 1:** Show the MSSQL connection in the sidebar — expand the database to briefly show the tables (Customers, Accounts, Loans, Transactions, CreditScores). Takes 5 seconds.

**Voiceover:**
> "I'm in VS Code, connected to a Fabric SQL Database using the MSSQL extension. This database holds our customer data — accounts, loans, transactions, and credit scores. Let me start with a simple query."

**Action 2:** Type the following comment and press Enter:

```sql
-- Show me all customers with their segment and risk profile, ordered by onboarding date
```

**Action 3:** Let Copilot ghost-text appear. Accept it with Tab.

**Voiceover:**
> "Watch — I type a comment describing what I need, and GitHub Copilot generates the SQL. It's grounded to our Fabric database schema, so it knows the exact table and column names. No guessing."

**Action 4:** Run the query. Show results briefly.

---

### SCENE 3: VS Code — The Star Query (60-90 seconds)

**Screen:** VS Code, open Copilot Chat panel

**Voiceover:**
> "Now let's try a real business question — the kind a risk analyst would ask. I need to find at-risk customers: those with low credit scores, active loans, and unusually large recent transactions."

**Action 1:** Open Copilot Chat (Ctrl+L). Type:

```
Find all customers with active loans and credit score below 650 who had a transaction over $10K in the last 30 days. Include their loan details and transaction info.
```

**Action 2:** Wait for Copilot to generate the query. Briefly scroll through it.

**Voiceover:**
> "Copilot generates a multi-table join across Customers, CreditScores, Loans, Accounts, and Transactions — all grounded to our actual schema. Let me run this."

**Action 3:** Insert the query into the editor, then run it.

**Voiceover (reading results):**
> "Three customers flagged: Michael Thompson with a credit score of 520 and 75 days delinquent on a personal loan... David Kim at 480 with wire transfers totaling over $25,000... and Lisa Johnson at 535. All have large wire transfers in the last 30 days."

**Pause briefly, then:**
> "This is incredibly powerful for developers. But what about the business analyst or the risk manager who needs this same answer — without writing SQL? That's where Fabric IQ comes in."

---

### SCENE 4: Fabric Portal — Ontology Graph (60-75 seconds)

**Screen:** Switch to browser → Fabric portal → Ontology graph preview

**Voiceover:**
> "Let me switch to the Fabric portal. This is Fabric IQ — specifically, the Ontology. It's a shared business vocabulary that defines what 'Customer', 'Account', 'Loan', and 'CreditScore' mean across our entire data estate."

**Action 1:** Show the ontology graph. Point out the entity types.

**Voiceover:**
> "You can see the five entity types — Customer, Account, Loan, Transaction, and CreditScore — and the relationships: a Customer holds Accounts, owes Loans, and has CreditScores. Accounts have Transactions."

**Action 2:** Click on a Customer node (ideally Michael Thompson) to show connected entities.

**Voiceover:**
> "When I click on Michael Thompson, I can see all his connected entities — his checking account, his delinquent personal loan, his credit score history, and his recent transactions. This is the knowledge graph for our business."

**Action 3:** Briefly show 2-3 more nodes to demonstrate the graph is navigable.

**Voiceover:**
> "The key insight here is: this ontology is defined once, and it powers everything downstream — reports in Power BI, queries from developers, and as we're about to see, AI agents for business users."

---

### SCENE 5: Fabric Portal — Data Agent (60-75 seconds)

**Screen:** Switch to browser tab with Data Agent

**Voiceover:**
> "Now I'm opening the Data Agent — an AI assistant grounded in our ontology. Let me ask the exact same question I asked GitHub Copilot, but this time in plain English."

**Action 1:** Type into the Data Agent:

```
Which customers have active loans and a credit score below 650 who had a transaction over $10,000 in the last 30 days?
```

**Action 2:** Wait for the response.

**Voiceover:**
> "Same answer. Michael Thompson, David Kim, Lisa Johnson — the same three customers. But notice the language: the agent uses 'Customer', 'CreditScore', 'Loan' — exactly as we defined them in our ontology."

**Action 3:** Type a follow-up:

```
Tell me more about Michael Thompson — what accounts does he have, what's his loan status, and what were his recent large transactions?
```

**Voiceover:**
> "I can drill into any customer. The agent traverses the ontology relationships — Customer to Account to Transaction, Customer to Loan, Customer to CreditScore — all governed by the same vocabulary."

---

### SCENE 6: Closing — The Integration Story (30-45 seconds)

**Screen:** Architecture diagram overlay (use the sequence diagram from `assets/architecture-diagram.md`)

**Voiceover:**
> "Let's step back and look at what just happened. A developer used GitHub Copilot in VS Code to write precise SQL against a Fabric database. A business analyst used the Data Agent in Fabric portal to ask the same question in plain English. Both got the same, governed answer."

> "The secret is the shared semantic layer — Fabric IQ's ontology. It defines the business vocabulary once, and that vocabulary powers everything: developer tooling, AI agents, Power BI reports, and graph analysis."

> "This is the Microsoft ecosystem advantage — GitHub Copilot for developer velocity, Fabric IQ for business semantics, and a unified data platform that ensures everyone speaks the same language."

**End card:** Show GitHub + Fabric logos, or the mindmap diagram from `assets/architecture-diagram.md`.

---

## Timing Summary

| Scene | Content | Duration |
|---|---|---|
| 1 | Title card + intro | 10 sec |
| 2 | VS Code — Copilot warm-up | 45-60 sec |
| 3 | VS Code — Star query | 60-90 sec |
| 4 | Fabric portal — Ontology graph | 60-75 sec |
| 5 | Fabric portal — Data Agent | 60-75 sec |
| 6 | Closing — Integration story | 30-45 sec |
| **Total** | | **~5-6 minutes** |

---

## Recording Tips

1. **Rehearse twice** before recording — Copilot responses may vary slightly
2. **Pre-warm Copilot** by opening the SQL file and typing a few queries beforehand (this loads the schema context)
3. **Move your mouse slowly** — viewers need to see where you're clicking
4. **Pause after each result** for 2-3 seconds so the audience can read
5. **If Copilot gives an imperfect query**, that's actually great — show the edit and say "I can refine this" — it demonstrates real usage
6. **Record each scene separately** if needed — you can stitch them together in editing
7. **Keep the Data Agent tab pre-loaded** to avoid load time on camera
8. **Zoom into results** when showing the three flagged customers — this is your climax moment

---

## Fallback Plan

If something doesn't work during recording:

| Issue | Fallback |
|---|---|
| Copilot doesn't generate the right query | Use the pre-written queries from `copilot-demo/demo-queries.sql` |
| Data Agent is slow to respond | Pre-record the agent response and splice it in |
| Ontology graph doesn't render | Use a screenshot or the Mermaid ER diagram from `assets/` |
| MSSQL connection drops | Re-record that scene — it's a 30-second fix |

---

## Post-Recording

- [ ] Review video for audio clarity
- [ ] Add architecture diagrams as overlays at Scene 1 and Scene 6
- [ ] Add subtle zoom on the query results at Scene 3 and Scene 5
- [ ] Optional: Add a lower-third text overlay showing the question being asked at each stage
- [ ] Export at 1080p minimum
