# Data Agent Prompts for Demo

Natural language questions to ask the Fabric IQ Data Agent during the Fabric portal portion of the demo. These mirror the VS Code queries to demonstrate the "same question, two personas" integration story.

## Setup Reminder

1. Open the Fabric portal
2. Navigate to your workspace → `Customer360_Agent`
3. Ensure the Data Agent has the ontology as its source
4. Have the ontology graph preview open in another tab (for switching)

---

## Prompt 1: The Star Query — Same Question, No Code (60 seconds)

> **CRITICAL:** This is the same question you just asked Copilot in VS Code.
> The audience should immediately recognize the parallel.

**Type into Data Agent:**

```
Which customers have active loans and a credit score below 650 who had a transaction over $10,000 in the last 30 days?
```

**What to say:** "Now I'm in the Fabric portal as a business analyst. No VS Code, no SQL. I'll ask the exact same question in plain English."

**What audience sees:** The Data Agent returns the same three customers (Michael Thompson, David Kim, Lisa Johnson) with their details — using the ontology's business terminology.

**What to say after:** "Same answer. Same three customers. But notice the language — the agent uses terms like 'Customer', 'CreditScore', 'Loan' exactly as we defined them in our ontology. That's the power of a shared semantic layer."

---

## Prompt 2: Follow-up — Drill Into a Customer (30 seconds)

**Type into Data Agent:**

```
Tell me more about Michael Thompson — what accounts does he have, what's his loan status, and what were his recent large transactions?
```

**What to say:** "I can drill into any customer. The agent understands the relationships — Customer holds Accounts, owes Loans, has CreditScores — all from the ontology."

**What audience sees:** A comprehensive Customer 360 view for Michael Thompson, with data pulled across all related entities.

---

## Prompt 3: Ontology-Grounded Analytical Question (30 seconds)

**Type into Data Agent:**

```
How many customers in each segment have delinquent loans?
```

**What to say:** "Business analysts can ask analytical questions using the business vocabulary, not table names."

**What audience sees:** A summary showing Standard segment has the most delinquent loans.

---

## Prompt 4: Relationship Traversal (30 seconds, optional if time permits)

**Type into Data Agent:**

```
Which customers have the highest total outstanding debt across all their loans and what are their credit scores?
```

**What to say:** "The agent traverses across Customer, Loan, and CreditScore — all governed by the ontology relationships."

---

## Key Talking Points for Data Agent Section

- "Same question, same answer, different persona — that's the integration story"
- "The Data Agent doesn't just query tables — it reasons using the ontology's business vocabulary"
- "Customer, Account, Loan, CreditScore, Transaction — defined once in the ontology, used everywhere"
- "Developers get velocity with GitHub Copilot. Decision makers get self-service with Data Agent. Both are governed."
- "This is the Microsoft ecosystem advantage — one semantic layer powering VS Code, Fabric portal, Power BI, and AI agents"
