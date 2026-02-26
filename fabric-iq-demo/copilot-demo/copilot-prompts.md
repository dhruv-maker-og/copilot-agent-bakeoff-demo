# GitHub Copilot Prompts for Demo

Exact prompts to use during the VS Code portion of the demo. Copy-paste or type these live.

## Setup Reminder

1. Open VS Code with MSSQL extension connected to your Fabric SQL Database
2. Ensure GitHub Copilot is active (check the Copilot icon in the status bar)
3. Open file: `copilot-demo/demo-queries.sql`
4. Have Copilot Chat panel open on the right side

---

## Prompt 1: Inline Comment Completion (30 seconds)

**What you do:** Type this comment in the SQL file, press Enter, and let Copilot autocomplete.

```sql
-- Show me all customers with their segment and risk profile, ordered by onboarding date
```

**What to say:** "I'm connected to our Fabric SQL Database directly from VS Code. Watch how GitHub Copilot understands the schema and generates the right query."

**What audience sees:** Copilot ghost-text appears with a complete SELECT query using the correct table and column names.

---

## Prompt 2: The Star Query — Copilot Chat Agent Mode (60-90 seconds)

**What you do:** Open Copilot Chat (Ctrl+L) and type this prompt:

```
Find all customers with active loans and credit score below 650 who had a transaction over $10K in the last 30 days. Include their loan details and transaction info.
```

**What to say:** "Now here's a real business question — the kind a risk analyst would ask. Instead of writing complex joins across five tables manually, I'll ask GitHub Copilot in Agent Mode."

**What audience sees:** Copilot generates a multi-table JOIN query that correctly uses the Fabric database schema.

**Follow-up to say:** "Notice it joined Customers, CreditScores, Loans, Accounts, and Transactions — all grounded to our actual Fabric database schema. Let me run this."

**After running:** "We found Michael Thompson, David Kim, and Lisa Johnson — all with poor credit scores, delinquent loans, and large recent wire transfers. Now let's see how a business analyst gets this SAME answer without writing any code."

> **TRANSITION CUE:** "This is where Fabric IQ's ontology and Data Agent come in..."

---

## Prompt 3: Portfolio Summary (30-45 seconds)

**What you do:** In Copilot Chat, type:

```
Write a query that summarizes our total loan exposure by customer segment, including count of delinquent loans and total outstanding debt
```

**What to say:** "Copilot can also help with analytical rollups. Let me ask for a portfolio exposure summary."

**What audience sees:** A GROUP BY query with aggregate functions, correctly structured.

---

## Prompt 4: Leveraging Pre-Built Views (30 seconds)

**What you do:** In Copilot Chat, type:

```
Using the vw_Customer360 view, find all customers whose credit score band is Poor and who have delinquent loans
```

**What to say:** "Copilot even recognizes the analytical views we've built — it doesn't have to rejoin everything from scratch."

---

## Key Talking Points for VS Code Section

- "GitHub Copilot is grounded to our Fabric SQL Database schema — it knows our tables, columns, and views"
- "Developers get velocity — complex multi-table joins in seconds"
- "But only developers can benefit from this today. What about the business analyst who needs the same answer?"
- "That's the integration story — same data, same semantic meaning, different persona"
