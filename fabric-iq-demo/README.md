# Fabric IQ + GitHub Copilot: Customer 360 Demo

A pre-recorded demo showcasing how **Microsoft Fabric IQ** and **GitHub Copilot** work together to deliver a unified Customer 360 experience for financial services — targeting a mixed audience of technical decision makers and developers.

## Demo Concept

**"Customer 360 — Unified Financial Profile"**

A bank unifies customer data across loans, accounts, and transactions using Fabric IQ's ontology. Both developers (in VS Code with GitHub Copilot) and business analysts (in Fabric portal with Data Agent) get consistent, governed answers — powered by the same semantic foundation.

## Architecture

```
Power BI Semantic Model
        │ (generates)
        ▼
Fabric IQ Ontology (shared business vocabulary)
        │                          │
        ▼ (grounds)                ▼ (grounds)
GitHub Copilot in VS Code    Data Agent in Fabric Portal
  (developer writes SQL)      (analyst asks in English)
        │                          │
        ▼                          ▼
    Same governed answer from Fabric SQL Database
```

## Folder Structure

```
fabric-iq-demo/
├── README.md                           # This file
├── DEMO-WALKTHROUGH.md                 # Step-by-step video recording guide
├── data/
│   ├── 01-create-tables.sql            # DDL for Fabric SQL Database
│   ├── 02-seed-data.sql                # Sample financial data
│   └── 03-create-views.sql             # Analytical views
├── ontology/
│   ├── ontology-definition.md          # Entity types, properties, relationships
│   └── ontology-setup-guide.md         # How to create the ontology in Fabric
├── copilot-demo/
│   ├── demo-queries.sql                # Queries to demonstrate with Copilot
│   └── copilot-prompts.md              # Exact prompts to type in Copilot chat
├── data-agent/
│   └── data-agent-prompts.md           # Natural language questions for Data Agent
└── assets/
    └── architecture-diagram.md         # Mermaid diagram for video overlay
```

## Prerequisites

| Requirement | Details |
|---|---|
| Microsoft Fabric capacity | F2 or higher SKU (or 60-day trial) |
| Fabric IQ (preview) | Ontology + Graph enabled in tenant settings |
| Copilot in Fabric | Enabled in tenant admin settings |
| VS Code | With MSSQL extension + GitHub Copilot |
| Fabric SQL Database | Created in a Fabric workspace |

## Quick Start

1. Read [`DEMO-WALKTHROUGH.md`](DEMO-WALKTHROUGH.md) for the full recording guide
2. Run the SQL scripts in `data/` against your Fabric SQL Database
3. Create the ontology in Fabric IQ using `ontology/ontology-setup-guide.md`
4. Open `copilot-demo/demo-queries.sql` in VS Code connected to Fabric
5. Record!

## License

MIT
