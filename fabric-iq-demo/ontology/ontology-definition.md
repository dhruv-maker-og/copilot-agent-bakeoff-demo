# Ontology Definition: Customer 360 for Financial Services

This document defines the entity types, properties, relationships, and constraints for the Customer 360 ontology in Fabric IQ.

## Entity Types

### Customer
| Property | Type | Description | Source Column |
|---|---|---|---|
| CustomerID | Integer (Identifier) | Unique customer identifier | `dbo.Customers.CustomerID` |
| FullName | String | First + Last name | Derived: `FirstName + ' ' + LastName` |
| Email | String | Contact email | `dbo.Customers.Email` |
| CustomerSegment | String | Tier: VIP, Premium, Standard | `dbo.Customers.CustomerSegment` |
| RiskProfile | String | Risk category: Low, Medium, High | `dbo.Customers.RiskProfile` |
| OnboardingDate | Date | Date customer joined | `dbo.Customers.OnboardingDate` |
| City | String | Customer city | `dbo.Customers.City` |
| State | String | Customer state | `dbo.Customers.State` |

### Account
| Property | Type | Description | Source Column |
|---|---|---|---|
| AccountID | Integer (Identifier) | Unique account identifier | `dbo.Accounts.AccountID` |
| AccountType | String | Checking, Savings, Investment | `dbo.Accounts.AccountType` |
| AccountStatus | String | Active, Closed, Frozen | `dbo.Accounts.AccountStatus` |
| CurrentBalance | Decimal | Current balance in USD | `dbo.Accounts.CurrentBalance` |
| OpenedDate | Date | Date account was opened | `dbo.Accounts.OpenedDate` |

### Loan
| Property | Type | Description | Source Column |
|---|---|---|---|
| LoanID | Integer (Identifier) | Unique loan identifier | `dbo.Loans.LoanID` |
| LoanType | String | Mortgage, Personal, Auto, Business | `dbo.Loans.LoanType` |
| LoanStatus | String | Active, Paid Off, Delinquent, Default | `dbo.Loans.LoanStatus` |
| PrincipalAmount | Decimal | Original loan amount | `dbo.Loans.PrincipalAmount` |
| OutstandingBalance | Decimal | Remaining balance | `dbo.Loans.OutstandingBalance` |
| InterestRate | Decimal | Annual interest rate (%) | `dbo.Loans.InterestRate` |
| DaysDelinquent | Integer | Days past due | `dbo.Loans.DaysDelinquent` |
| MonthlyPayment | Decimal | Monthly payment amount | `dbo.Loans.MonthlyPayment` |

### Transaction
| Property | Type | Description | Source Column |
|---|---|---|---|
| TransactionID | BigInteger (Identifier) | Unique transaction identifier | `dbo.Transactions.TransactionID` |
| TransactionDate | DateTime | When the transaction occurred | `dbo.Transactions.TransactionDate` |
| TransactionType | String | Deposit, Withdrawal, Transfer, Payment, Fee | `dbo.Transactions.TransactionType` |
| Amount | Decimal | Transaction amount in USD | `dbo.Transactions.Amount` |
| MerchantCategory | String | Category of merchant/payee | `dbo.Transactions.MerchantCategory` |
| Channel | String | Online, Branch, ATM, Mobile | `dbo.Transactions.Channel` |

### CreditScore
| Property | Type | Description | Source Column |
|---|---|---|---|
| CreditScoreID | Integer (Identifier) | Unique score record identifier | `dbo.CreditScores.CreditScoreID` |
| Score | Integer | Numeric credit score (300-850) | `dbo.CreditScores.Score` |
| ScoreBand | String | Excellent, Good, Fair, Poor | `dbo.CreditScores.ScoreBand` |
| ScoreDate | Date | Date the score was recorded | `dbo.CreditScores.ScoreDate` |
| ScoreProvider | String | FICO, VantageScore | `dbo.CreditScores.ScoreProvider` |

## Relationship Types

| Relationship | From | To | Cardinality | Description |
|---|---|---|---|---|
| **holds** | Customer | Account | 1:Many | A customer holds one or more accounts |
| **owes** | Customer | Loan | 1:Many | A customer has one or more loans |
| **has_score** | Customer | CreditScore | 1:Many | A customer has credit score history |
| **transacted_on** | Account | Transaction | 1:Many | An account has many transactions |

## Graph Visualization

When built, the ontology graph will show:

```
[Customer] --holds--> [Account] --transacted_on--> [Transaction]
    |                                                    
    |--owes--> [Loan]
    |
    |--has_score--> [CreditScore]
```

This enables traversal queries like:
- "Which customers with Poor credit scores have accounts with transactions over $10,000?"
- "Show all loans for customers in the VIP segment"
- "Trace the relationship: Customer → Delinquent Loan → Low Credit Score → Large Transactions"

## Constraints & Rules

| Rule | Entity | Constraint |
|---|---|---|
| Credit score range | CreditScore | Score BETWEEN 300 AND 850 |
| Balance non-negative | Account | CurrentBalance >= 0 |
| Valid segment | Customer | CustomerSegment IN ('VIP', 'Premium', 'Standard') |
| Valid loan status | Loan | LoanStatus IN ('Active', 'Paid Off', 'Delinquent', 'Default') |
