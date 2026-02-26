-- ============================================================================
-- Fabric IQ + GitHub Copilot Demo: VS Code Demo Queries
-- ============================================================================
-- These queries are designed to be written WITH GitHub Copilot's help during
-- the demo. Start with a comment prompt, then let Copilot generate the SQL.
--
-- SETUP: Connect VS Code to your Fabric SQL Database using the MSSQL extension.
-- GitHub Copilot will automatically ground its suggestions to your schema.
-- ============================================================================


-- ============================================================================
-- QUERY 1: Warm-up — Show Copilot understands the schema
-- ============================================================================
-- DEMO ACTION: Type this comment, then let Copilot autocomplete the query.
-- Show the audience that Copilot knows your Fabric database schema.

-- Show me all customers with their segment and risk profile, ordered by onboarding date

-- EXPECTED OUTPUT (Copilot should generate something like):
SELECT
    CustomerID,
    FirstName + ' ' + LastName AS FullName,
    CustomerSegment,
    RiskProfile,
    OnboardingDate,
    City,
    State
FROM dbo.Customers
ORDER BY OnboardingDate ASC;


-- ============================================================================
-- QUERY 2: The Key Demo Query — Cross-domain risk analysis
-- ============================================================================
-- DEMO ACTION: This is the STAR query. Type the comment below into Copilot Chat
-- or as an inline comment. This is the SAME question you'll later ask the
-- Data Agent in Fabric portal — showing both personas get the same answer.

-- Find all customers with active loans and credit score below 650
-- who had a transaction over $10K in the last 30 days

-- EXPECTED OUTPUT (Copilot should generate something like):
SELECT DISTINCT
    c.CustomerID,
    c.FirstName + ' ' + LastName AS FullName,
    c.CustomerSegment,
    c.RiskProfile,
    cs.Score AS LatestCreditScore,
    cs.ScoreBand,
    l.LoanType,
    l.LoanStatus,
    l.OutstandingBalance,
    l.DaysDelinquent,
    t.TransactionDate,
    t.Amount AS TransactionAmount,
    t.TransactionType,
    t.MerchantCategory
FROM dbo.Customers c
INNER JOIN dbo.CreditScores cs ON c.CustomerID = cs.CustomerID
INNER JOIN dbo.Loans l ON c.CustomerID = l.CustomerID
INNER JOIN dbo.Accounts a ON c.CustomerID = a.CustomerID
INNER JOIN dbo.Transactions t ON a.AccountID = t.AccountID
WHERE cs.ScoreDate = (
    SELECT MAX(ScoreDate)
    FROM dbo.CreditScores
    WHERE CustomerID = c.CustomerID
)
AND cs.Score < 650
AND l.LoanStatus IN ('Active', 'Delinquent')
AND t.Amount > 10000
AND t.TransactionDate >= DATEADD(DAY, -30, GETDATE())
ORDER BY cs.Score ASC, t.Amount DESC;

-- EXPECTED RESULTS: Should return Michael Thompson, David Kim, and Lisa Johnson
-- with their delinquent loans and large wire transfers.


-- ============================================================================
-- QUERY 3: Portfolio exposure summary
-- ============================================================================
-- DEMO ACTION: Use Copilot Chat (Ctrl+I or sidebar) with Agent Mode.
-- Ask: "Write a query that summarizes our total loan exposure by customer
--       segment, including count of delinquent loans and total outstanding debt"

-- EXPECTED OUTPUT:
SELECT
    c.CustomerSegment,
    COUNT(DISTINCT c.CustomerID)                                     AS CustomerCount,
    COUNT(l.LoanID)                                                  AS TotalLoans,
    SUM(CASE WHEN l.LoanStatus = 'Delinquent' THEN 1 ELSE 0 END)   AS DelinquentLoans,
    SUM(l.OutstandingBalance)                                        AS TotalOutstandingDebt,
    AVG(l.InterestRate)                                              AS AvgInterestRate,
    MAX(l.DaysDelinquent)                                            AS MaxDaysDelinquent
FROM dbo.Customers c
INNER JOIN dbo.Loans l ON c.CustomerID = l.CustomerID
WHERE l.LoanStatus IN ('Active', 'Delinquent')
GROUP BY c.CustomerSegment
ORDER BY TotalOutstandingDebt DESC;


-- ============================================================================
-- QUERY 4: Customer 360 view (show Copilot leveraging the pre-built view)
-- ============================================================================
-- DEMO ACTION: Ask Copilot Chat:
-- "Using the vw_Customer360 view, find all customers whose credit score
--  dropped and who have delinquent loans"

-- EXPECTED OUTPUT:
SELECT
    CustomerID,
    FullName,
    CustomerSegment,
    RiskProfile,
    LatestCreditScore,
    CreditScoreBand,
    ActiveLoans,
    TotalOutstandingDebt,
    MaxDaysDelinquent,
    TransactionCount_30d,
    LargestTransaction_30d
FROM dbo.vw_Customer360
WHERE CreditScoreBand = 'Poor'
  AND MaxDaysDelinquent > 0
ORDER BY LatestCreditScore ASC;
