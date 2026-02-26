-- ============================================================================
-- Fabric IQ + GitHub Copilot Demo: Customer 360 for Financial Services
-- Step 1: Create Tables in Fabric SQL Database
-- ============================================================================
-- Run this script against your Fabric SQL Database.
-- These tables form the transactional foundation for the Customer 360 ontology.
-- ============================================================================

-- Customers
CREATE TABLE dbo.Customers (
    CustomerID          INT             NOT NULL PRIMARY KEY,
    FirstName           NVARCHAR(100)   NOT NULL,
    LastName            NVARCHAR(100)   NOT NULL,
    Email               NVARCHAR(255)   NULL,
    Phone               NVARCHAR(20)    NULL,
    DateOfBirth         DATE            NULL,
    CustomerSegment     NVARCHAR(50)    NOT NULL,  -- 'Premium', 'Standard', 'VIP'
    RiskProfile         NVARCHAR(50)    NOT NULL,  -- 'Low', 'Medium', 'High'
    OnboardingDate      DATE            NOT NULL,
    City                NVARCHAR(100)   NULL,
    State               NVARCHAR(50)    NULL,
    Country             NVARCHAR(100)   NOT NULL DEFAULT 'United States'
);

-- Accounts
CREATE TABLE dbo.Accounts (
    AccountID           INT             NOT NULL PRIMARY KEY,
    CustomerID          INT             NOT NULL,
    AccountType         NVARCHAR(50)    NOT NULL,  -- 'Checking', 'Savings', 'Investment'
    AccountStatus       NVARCHAR(20)    NOT NULL,  -- 'Active', 'Closed', 'Frozen'
    OpenedDate          DATE            NOT NULL,
    CurrentBalance      DECIMAL(18, 2)  NOT NULL,
    Currency            NVARCHAR(3)     NOT NULL DEFAULT 'USD',
    BranchCode          NVARCHAR(10)    NULL,
    CONSTRAINT FK_Accounts_Customers FOREIGN KEY (CustomerID) REFERENCES dbo.Customers(CustomerID)
);

-- Loans
CREATE TABLE dbo.Loans (
    LoanID              INT             NOT NULL PRIMARY KEY,
    CustomerID          INT             NOT NULL,
    LoanType            NVARCHAR(50)    NOT NULL,  -- 'Mortgage', 'Personal', 'Auto', 'Business'
    LoanStatus          NVARCHAR(20)    NOT NULL,  -- 'Active', 'Paid Off', 'Delinquent', 'Default'
    PrincipalAmount     DECIMAL(18, 2)  NOT NULL,
    OutstandingBalance  DECIMAL(18, 2)  NOT NULL,
    InterestRate        DECIMAL(5, 2)   NOT NULL,
    OriginationDate     DATE            NOT NULL,
    MaturityDate        DATE            NOT NULL,
    MonthlyPayment      DECIMAL(18, 2)  NOT NULL,
    DaysDelinquent      INT             NOT NULL DEFAULT 0,
    CONSTRAINT FK_Loans_Customers FOREIGN KEY (CustomerID) REFERENCES dbo.Customers(CustomerID)
);

-- Transactions
CREATE TABLE dbo.Transactions (
    TransactionID       BIGINT          NOT NULL PRIMARY KEY,
    AccountID           INT             NOT NULL,
    TransactionDate     DATETIME2       NOT NULL,
    TransactionType     NVARCHAR(50)    NOT NULL,  -- 'Deposit', 'Withdrawal', 'Transfer', 'Payment', 'Fee'
    Amount              DECIMAL(18, 2)  NOT NULL,
    MerchantCategory    NVARCHAR(100)   NULL,
    Description         NVARCHAR(500)   NULL,
    Channel             NVARCHAR(50)    NULL,       -- 'Online', 'Branch', 'ATM', 'Mobile'
    CONSTRAINT FK_Transactions_Accounts FOREIGN KEY (AccountID) REFERENCES dbo.Accounts(AccountID)
);

-- Credit Scores (point-in-time snapshots)
CREATE TABLE dbo.CreditScores (
    CreditScoreID       INT             NOT NULL PRIMARY KEY,
    CustomerID          INT             NOT NULL,
    ScoreDate           DATE            NOT NULL,
    Score               INT             NOT NULL,   -- 300-850
    ScoreProvider       NVARCHAR(50)    NOT NULL,   -- 'FICO', 'VantageScore'
    ScoreBand           NVARCHAR(20)    NOT NULL,   -- 'Excellent', 'Good', 'Fair', 'Poor'
    CONSTRAINT FK_CreditScores_Customers FOREIGN KEY (CustomerID) REFERENCES dbo.Customers(CustomerID)
);

GO

PRINT 'All tables created successfully.';
