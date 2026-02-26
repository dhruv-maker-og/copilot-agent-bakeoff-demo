# Architecture Diagrams for Video

Use these Mermaid diagrams as overlays or title cards in the demo video.

## Main Architecture — Integration Flow

```mermaid
flowchart TB
    subgraph POWERBI["Power BI"]
        SM["Semantic Model<br/>(Customer, Account,<br/>Loan, Transaction)"]
    end

    subgraph FABRICIQ["Fabric IQ"]
        ONT["Ontology<br/>Shared Business Vocabulary"]
        GRAPH["Graph<br/>Entity Relationships"]
    end

    subgraph FABRICDB["Fabric SQL Database"]
        TABLES[("Customers | Accounts<br/>Loans | Transactions<br/>CreditScores")]
    end

    subgraph DEVEXP["Developer Experience"]
        VSCODE["VS Code + MSSQL Extension"]
        COPILOT["GitHub Copilot<br/>Agent Mode"]
    end

    subgraph BIZEXP["Business Analyst Experience"]
        AGENT["Fabric Data Agent<br/>Natural Language Q&A"]
    end

    SM -->|generates| ONT
    ONT -->|builds| GRAPH
    ONT -->|grounds| AGENT
    TABLES -->|binds to| ONT
    TABLES -->|schema grounds| COPILOT
    VSCODE --- COPILOT
    COPILOT -->|queries| TABLES
    AGENT -->|queries via ontology| TABLES

    style POWERBI fill:#F2C811,stroke:#333,color:#000
    style FABRICIQ fill:#0078D4,stroke:#333,color:#fff
    style FABRICDB fill:#4DB8FF,stroke:#333,color:#000
    style DEVEXP fill:#24292E,stroke:#333,color:#fff
    style BIZEXP fill:#7719AA,stroke:#333,color:#fff
```

## Ontology Entity Relationship Diagram

```mermaid
erDiagram
    CUSTOMER ||--o{ ACCOUNT : holds
    CUSTOMER ||--o{ LOAN : owes
    CUSTOMER ||--o{ CREDIT_SCORE : has_score
    ACCOUNT ||--o{ TRANSACTION : transacted_on

    CUSTOMER {
        int CustomerID PK
        string FullName
        string Email
        string CustomerSegment
        string RiskProfile
        date OnboardingDate
    }

    ACCOUNT {
        int AccountID PK
        string AccountType
        string AccountStatus
        decimal CurrentBalance
    }

    LOAN {
        int LoanID PK
        string LoanType
        string LoanStatus
        decimal OutstandingBalance
        int DaysDelinquent
    }

    TRANSACTION {
        bigint TransactionID PK
        datetime TransactionDate
        string TransactionType
        decimal Amount
        string Channel
    }

    CREDIT_SCORE {
        int CreditScoreID PK
        int Score
        string ScoreBand
        date ScoreDate
    }
```

## Demo Flow Sequence

```mermaid
sequenceDiagram
    participant Dev as Developer (VS Code)
    participant GHC as GitHub Copilot
    participant FDB as Fabric SQL Database
    participant ONT as IQ Ontology
    participant DA as Data Agent
    participant BA as Business Analyst

    Note over Dev,GHC: Part 1: Developer Experience
    Dev->>GHC: "Find customers with low credit<br/>and large recent transactions"
    GHC->>FDB: Generated T-SQL query<br/>(schema-grounded)
    FDB-->>GHC: Michael Thompson, David Kim,<br/>Lisa Johnson
    GHC-->>Dev: Results displayed

    Note over ONT,DA: Part 2: Ontology (shown in portal)
    Note over ONT: Customer → Account → Transaction<br/>Customer → Loan<br/>Customer → CreditScore

    Note over DA,BA: Part 3: Business Analyst Experience
    BA->>DA: "Which customers have active loans<br/>and credit score below 650 with<br/>transactions over $10K?"
    DA->>ONT: Resolves business terms
    ONT->>FDB: Structured query
    FDB-->>DA: Same 3 customers
    DA-->>BA: Answer in business language

    Note over Dev,BA: Same Answer. Same Semantics.<br/>Different Persona.
```

## Title Card — Value Proposition

```mermaid
mindmap
  root((Fabric IQ +<br/>GitHub Copilot))
    Developer
      VS Code + MSSQL Extension
      GitHub Copilot Agent Mode
      Schema-grounded SQL generation
      Fast iteration & debugging
    Business Analyst
      Fabric Data Agent
      Natural language Q&A
      Ontology-powered answers
      No code required
    Shared Foundation
      IQ Ontology
      Unified business vocabulary
      Graph relationships
      Governed semantics
    Data Platform
      Fabric SQL Database
      Power BI Semantic Models
      OneLake
      Single source of truth
```
