# Ontology Setup Guide: Creating the Customer 360 Ontology in Fabric IQ

Follow these steps to create the ontology in Microsoft Fabric IQ (preview). You'll do this in the **Fabric portal** before recording the demo.

## Prerequisites

- [ ] Fabric capacity (F2 or higher, or active trial)
- [ ] Fabric IQ (preview) enabled in tenant admin settings
- [ ] Graph in Microsoft Fabric enabled in tenant admin settings
- [ ] Copilot enabled in tenant admin settings
- [ ] A Fabric workspace with your SQL Database containing the demo tables

### Enable Required Tenant Settings

1. Go to **Fabric Admin Portal** → **Tenant Settings**
2. Enable: **Users can create and use Ontology (preview)**
3. Enable: **Users can create and use Graph in Microsoft Fabric (preview)**
4. Enable: **Copilot and Azure OpenAI Service** → Turn on Copilot
5. Wait 5-15 minutes for settings to propagate

## Step 1: Create the Ontology Item

1. Open your **Fabric workspace** in the portal
2. Click **+ New item**
3. Under the **IQ** section, select **Ontology (preview)**
4. Name it: `Customer360_Ontology`
5. Click **Create**

## Step 2: Create Entity Types

In the ontology editor:

### 2a. Customer Entity Type
1. Click **+ Add entity type**
2. Name: `Customer`
3. Description: `A bank customer with accounts, loans, and credit history`
4. Add properties:
   - `CustomerID` (Integer, mark as **Identifier**)
   - `FullName` (String)
   - `Email` (String)
   - `CustomerSegment` (String) — description: "VIP, Premium, or Standard"
   - `RiskProfile` (String) — description: "Low, Medium, or High"
   - `OnboardingDate` (Date)
   - `City` (String)
   - `State` (String)

### 2b. Account Entity Type
1. Click **+ Add entity type**
2. Name: `Account`
3. Description: `A financial account (checking, savings, or investment)`
4. Add properties:
   - `AccountID` (Integer, mark as **Identifier**)
   - `AccountType` (String) — description: "Checking, Savings, or Investment"
   - `AccountStatus` (String)
   - `CurrentBalance` (Decimal)
   - `OpenedDate` (Date)

### 2c. Loan Entity Type
1. Click **+ Add entity type**
2. Name: `Loan`
3. Description: `A loan product (mortgage, personal, auto, or business)`
4. Add properties:
   - `LoanID` (Integer, mark as **Identifier**)
   - `LoanType` (String)
   - `LoanStatus` (String) — description: "Active, Paid Off, Delinquent, or Default"
   - `PrincipalAmount` (Decimal)
   - `OutstandingBalance` (Decimal)
   - `InterestRate` (Decimal)
   - `DaysDelinquent` (Integer)
   - `MonthlyPayment` (Decimal)

### 2d. Transaction Entity Type
1. Click **+ Add entity type**
2. Name: `Transaction`
3. Description: `A financial transaction (deposit, withdrawal, transfer, payment, or fee)`
4. Add properties:
   - `TransactionID` (BigInteger, mark as **Identifier**)
   - `TransactionDate` (DateTime)
   - `TransactionType` (String)
   - `Amount` (Decimal)
   - `MerchantCategory` (String)
   - `Channel` (String)

### 2e. CreditScore Entity Type
1. Click **+ Add entity type**
2. Name: `CreditScore`
3. Description: `A point-in-time credit score snapshot for a customer`
4. Add properties:
   - `CreditScoreID` (Integer, mark as **Identifier**)
   - `Score` (Integer) — description: "FICO score, range 300-850"
   - `ScoreBand` (String) — description: "Excellent, Good, Fair, or Poor"
   - `ScoreDate` (Date)
   - `ScoreProvider` (String)

## Step 3: Create Relationship Types

1. Click **+ Add relationship type**
2. Create these relationships:

| Name | From Entity | To Entity | Cardinality |
|---|---|---|---|
| `holds` | Customer | Account | One to Many |
| `owes` | Customer | Loan | One to Many |
| `has_score` | Customer | CreditScore | One to Many |
| `transacted_on` | Account | Transaction | One to Many |

## Step 4: Bind Data Sources

1. For each entity type, click **Bind data**
2. Select your **Fabric SQL Database** as the data source
3. Map entity properties to table columns:

| Entity Type | Source Table | Key Binding |
|---|---|---|
| Customer | `dbo.Customers` | CustomerID → CustomerID |
| Account | `dbo.Accounts` | AccountID → AccountID |
| Loan | `dbo.Loans` | LoanID → LoanID |
| Transaction | `dbo.Transactions` | TransactionID → TransactionID |
| CreditScore | `dbo.CreditScores` | CreditScoreID → CreditScoreID |

4. For relationships, bind the foreign keys:
   - `holds`: Accounts.CustomerID → Customers.CustomerID
   - `owes`: Loans.CustomerID → Customers.CustomerID
   - `has_score`: CreditScores.CustomerID → Customers.CustomerID
   - `transacted_on`: Transactions.AccountID → Accounts.AccountID

## Step 5: Preview the Ontology Graph

1. Click **Preview** in the ontology editor
2. You should see the graph with:
   - 12 Customer nodes
   - 22 Account nodes
   - 12 Loan nodes
   - 35 Transaction nodes
   - 18 CreditScore nodes
3. Click on a Customer node (e.g., "Michael Thompson") to see its connected entities
4. **This is what you'll show in the demo!**

## Step 6: Create Data Agent (for Demo Part 3)

1. Go back to your workspace
2. Click **+ New item** → **Data Agent (preview)** (under Data Science)
3. Name it: `Customer360_Agent`
4. In the agent configuration, add your **ontology** as a source
5. Test with: "Which customers have poor credit scores?"
6. Verify the agent uses ontology terminology in its response

## Verification Checklist

Before recording:

- [ ] All 5 entity types appear in the ontology editor
- [ ] All 4 relationships are defined
- [ ] Data bindings show green/healthy status
- [ ] Graph preview renders nodes and edges
- [ ] Data Agent responds to test questions using ontology terms
- [ ] VS Code can connect to the Fabric SQL Database via MSSQL extension
- [ ] GitHub Copilot is active in VS Code
