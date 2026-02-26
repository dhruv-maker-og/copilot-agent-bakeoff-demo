-- ============================================================================
-- Fabric IQ + GitHub Copilot Demo: Customer 360 for Financial Services
-- Step 3: Create Analytical Views
-- ============================================================================
-- These views pre-join data to support the ontology and make demo queries cleaner.
-- ============================================================================

-- Customer 360 Summary View
CREATE VIEW dbo.vw_Customer360 AS
SELECT
    c.CustomerID,
    c.FirstName + ' ' + c.LastName          AS FullName,
    c.Email,
    c.CustomerSegment,
    c.RiskProfile,
    c.OnboardingDate,
    c.City,
    c.State,
    -- Latest credit score
    cs.Score                                AS LatestCreditScore,
    cs.ScoreBand                            AS CreditScoreBand,
    cs.ScoreDate                            AS CreditScoreDate,
    -- Account summary
    acct.TotalAccounts,
    acct.TotalBalance,
    -- Loan summary
    ln.ActiveLoans,
    ln.TotalOutstandingDebt,
    ln.MaxDaysDelinquent,
    -- Transaction summary (last 30 days)
    txn.TransactionCount_30d,
    txn.TotalDeposits_30d,
    txn.TotalWithdrawals_30d,
    txn.LargestTransaction_30d
FROM dbo.Customers c
-- Latest credit score (most recent per customer)
OUTER APPLY (
    SELECT TOP 1 Score, ScoreBand, ScoreDate
    FROM dbo.CreditScores
    WHERE CustomerID = c.CustomerID
    ORDER BY ScoreDate DESC
) cs
-- Account rollup
OUTER APPLY (
    SELECT
        COUNT(*)            AS TotalAccounts,
        SUM(CurrentBalance) AS TotalBalance
    FROM dbo.Accounts
    WHERE CustomerID = c.CustomerID AND AccountStatus = 'Active'
) acct
-- Loan rollup
OUTER APPLY (
    SELECT
        COUNT(*)                AS ActiveLoans,
        SUM(OutstandingBalance) AS TotalOutstandingDebt,
        MAX(DaysDelinquent)     AS MaxDaysDelinquent
    FROM dbo.Loans
    WHERE CustomerID = c.CustomerID AND LoanStatus IN ('Active', 'Delinquent')
) ln
-- Transaction rollup (last 30 days)
OUTER APPLY (
    SELECT
        COUNT(*)                                                          AS TransactionCount_30d,
        SUM(CASE WHEN t.TransactionType = 'Deposit' THEN t.Amount ELSE 0 END)    AS TotalDeposits_30d,
        SUM(CASE WHEN t.TransactionType = 'Withdrawal' THEN t.Amount ELSE 0 END) AS TotalWithdrawals_30d,
        MAX(t.Amount)                                                     AS LargestTransaction_30d
    FROM dbo.Transactions t
    INNER JOIN dbo.Accounts a ON t.AccountID = a.AccountID
    WHERE a.CustomerID = c.CustomerID
      AND t.TransactionDate >= DATEADD(DAY, -30, GETDATE())
) txn;
GO

-- High-Risk Customer View (used in demo's key query)
CREATE VIEW dbo.vw_HighRiskCustomers AS
SELECT
    c.CustomerID,
    c.FirstName + ' ' + c.LastName  AS FullName,
    c.CustomerSegment,
    c.RiskProfile,
    cs.Score                        AS LatestCreditScore,
    cs.ScoreBand,
    l.LoanID,
    l.LoanType,
    l.LoanStatus,
    l.OutstandingBalance,
    l.DaysDelinquent,
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount                        AS TransactionAmount,
    t.MerchantCategory,
    t.Channel
FROM dbo.Customers c
INNER JOIN dbo.CreditScores cs ON c.CustomerID = cs.CustomerID
INNER JOIN dbo.Loans l ON c.CustomerID = l.CustomerID
INNER JOIN dbo.Accounts a ON c.CustomerID = a.CustomerID
INNER JOIN dbo.Transactions t ON a.AccountID = t.AccountID
WHERE cs.ScoreDate = (
    SELECT MAX(ScoreDate) FROM dbo.CreditScores WHERE CustomerID = c.CustomerID
)
AND cs.Score < 650
AND l.LoanStatus IN ('Active', 'Delinquent')
AND t.Amount > 10000
AND t.TransactionDate >= DATEADD(DAY, -30, GETDATE());
GO

PRINT 'Views created successfully.';
