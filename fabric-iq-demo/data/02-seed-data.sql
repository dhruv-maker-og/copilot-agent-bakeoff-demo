-- ============================================================================
-- Fabric IQ + GitHub Copilot Demo: Customer 360 for Financial Services
-- Step 2: Seed Sample Data
-- ============================================================================
-- Realistic financial services data with intentional patterns for demo queries:
--   - Customers with low credit scores AND large transactions (the key demo query)
--   - Mix of segments, risk profiles, and account types
--   - Delinquent loans for risk analysis
-- ============================================================================

-- ===================== CUSTOMERS =====================
INSERT INTO dbo.Customers (CustomerID, FirstName, LastName, Email, Phone, DateOfBirth, CustomerSegment, RiskProfile, OnboardingDate, City, State)
VALUES
(1001, 'Sarah',    'Mitchell',  'sarah.mitchell@email.com',    '555-0101', '1985-03-15', 'VIP',      'Low',    '2018-01-10', 'New York',      'NY'),
(1002, 'James',    'Rodriguez', 'james.rodriguez@email.com',   '555-0102', '1990-07-22', 'Premium',  'Medium', '2019-06-15', 'Los Angeles',   'CA'),
(1003, 'Emily',    'Chen',      'emily.chen@email.com',        '555-0103', '1978-11-08', 'Standard', 'Low',    '2020-02-01', 'Chicago',       'IL'),
(1004, 'Michael',  'Thompson',  'michael.t@email.com',         '555-0104', '1992-04-30', 'Standard', 'High',   '2021-09-20', 'Houston',       'TX'),
(1005, 'Aisha',    'Patel',     'aisha.patel@email.com',       '555-0105', '1988-12-05', 'Premium',  'Medium', '2017-03-12', 'Phoenix',       'AZ'),
(1006, 'David',    'Kim',       'david.kim@email.com',         '555-0106', '1995-08-18', 'Standard', 'High',   '2022-01-05', 'Philadelphia',  'PA'),
(1007, 'Maria',    'Santos',    'maria.santos@email.com',      '555-0107', '1982-06-25', 'VIP',      'Low',    '2016-11-30', 'San Antonio',   'TX'),
(1008, 'Robert',   'Williams',  'r.williams@email.com',        '555-0108', '1975-01-12', 'Premium',  'Medium', '2019-08-22', 'San Diego',     'CA'),
(1009, 'Jennifer', 'Brown',     'jen.brown@email.com',         '555-0109', '1998-09-03', 'Standard', 'Low',    '2023-04-15', 'Dallas',        'TX'),
(1010, 'Ahmed',    'Hassan',    'ahmed.hassan@email.com',      '555-0110', '1987-02-28', 'VIP',      'Low',    '2015-07-01', 'San Jose',      'CA'),
(1011, 'Lisa',     'Johnson',   'lisa.j@email.com',            '555-0111', '1993-05-14', 'Standard', 'High',   '2022-06-10', 'Austin',        'TX'),
(1012, 'Carlos',   'Garcia',    'carlos.g@email.com',          '555-0112', '1980-10-20', 'Premium',  'Medium', '2018-12-01', 'Jacksonville',  'FL');

-- ===================== ACCOUNTS =====================
INSERT INTO dbo.Accounts (AccountID, CustomerID, AccountType, AccountStatus, OpenedDate, CurrentBalance, Currency, BranchCode)
VALUES
-- Sarah Mitchell - VIP with multiple accounts
(2001, 1001, 'Checking',   'Active', '2018-01-10', 45230.00,  'USD', 'NYC-001'),
(2002, 1001, 'Savings',    'Active', '2018-01-10', 182500.00, 'USD', 'NYC-001'),
(2003, 1001, 'Investment', 'Active', '2018-06-15', 520000.00, 'USD', 'NYC-001'),
-- James Rodriguez
(2004, 1002, 'Checking',   'Active', '2019-06-15', 8750.00,   'USD', 'LAX-002'),
(2005, 1002, 'Savings',    'Active', '2019-06-15', 32100.00,  'USD', 'LAX-002'),
-- Emily Chen
(2006, 1003, 'Checking',   'Active', '2020-02-01', 5620.00,   'USD', 'CHI-001'),
(2007, 1003, 'Savings',    'Active', '2020-02-01', 15800.00,  'USD', 'CHI-001'),
-- Michael Thompson - High risk, low balance
(2008, 1004, 'Checking',   'Active', '2021-09-20', 1230.00,   'USD', 'HOU-001'),
-- Aisha Patel
(2009, 1005, 'Checking',   'Active', '2017-03-12', 22340.00,  'USD', 'PHX-001'),
(2010, 1005, 'Investment', 'Active', '2018-01-20', 175000.00, 'USD', 'PHX-001'),
-- David Kim - High risk
(2011, 1006, 'Checking',   'Active', '2022-01-05', 890.00,    'USD', 'PHL-001'),
-- Maria Santos - VIP
(2012, 1007, 'Checking',   'Active', '2016-11-30', 67800.00,  'USD', 'SAT-001'),
(2013, 1007, 'Savings',    'Active', '2016-11-30', 245000.00, 'USD', 'SAT-001'),
(2014, 1007, 'Investment', 'Active', '2017-03-01', 890000.00, 'USD', 'SAT-001'),
-- Robert Williams
(2015, 1008, 'Checking',   'Active', '2019-08-22', 15670.00,  'USD', 'SDG-001'),
(2016, 1008, 'Savings',    'Active', '2019-08-22', 48200.00,  'USD', 'SDG-001'),
-- Jennifer Brown
(2017, 1009, 'Checking',   'Active', '2023-04-15', 3200.00,   'USD', 'DAL-001'),
-- Ahmed Hassan - VIP
(2018, 1010, 'Checking',   'Active', '2015-07-01', 89400.00,  'USD', 'SJC-001'),
(2019, 1010, 'Investment', 'Active', '2015-09-01', 1250000.00,'USD', 'SJC-001'),
-- Lisa Johnson - High risk
(2020, 1011, 'Checking',   'Active', '2022-06-10', 2100.00,   'USD', 'AUS-001'),
-- Carlos Garcia
(2021, 1012, 'Checking',   'Active', '2018-12-01', 18900.00,  'USD', 'JAX-001'),
(2022, 1012, 'Savings',    'Active', '2018-12-01', 56700.00,  'USD', 'JAX-001');

-- ===================== LOANS =====================
INSERT INTO dbo.Loans (LoanID, CustomerID, LoanType, LoanStatus, PrincipalAmount, OutstandingBalance, InterestRate, OriginationDate, MaturityDate, MonthlyPayment, DaysDelinquent)
VALUES
-- Sarah Mitchell - Good standing
(3001, 1001, 'Mortgage', 'Active',     450000.00, 320000.00, 3.25, '2018-03-01', '2048-03-01', 1958.00, 0),
-- James Rodriguez - Starting to slip
(3002, 1002, 'Auto',     'Active',     35000.00,  22000.00,  5.50, '2020-01-15', '2026-01-15', 667.00,  15),
(3003, 1002, 'Personal', 'Active',     15000.00,  11200.00,  8.75, '2022-06-01', '2027-06-01', 308.00,  0),
-- Michael Thompson - HIGH RISK: Delinquent loan + low credit
(3004, 1004, 'Personal', 'Delinquent', 25000.00,  23500.00,  12.50, '2022-03-01', '2027-03-01', 564.00,  75),
(3005, 1004, 'Auto',     'Active',     18000.00,  15200.00,  9.00,  '2022-09-15', '2028-09-15', 375.00,  30),
-- Aisha Patel
(3006, 1005, 'Mortgage', 'Active',     380000.00, 295000.00, 3.75, '2019-01-10', '2049-01-10', 1760.00, 0),
-- David Kim - HIGH RISK: Delinquent
(3007, 1006, 'Personal', 'Delinquent', 10000.00,  9800.00,   14.00, '2023-01-15', '2026-01-15', 342.00,  90),
-- Maria Santos
(3008, 1007, 'Mortgage', 'Active',     650000.00, 380000.00, 2.90, '2017-06-01', '2047-06-01', 2705.00, 0),
-- Robert Williams
(3009, 1008, 'Mortgage', 'Active',     320000.00, 275000.00, 4.25, '2020-02-01', '2050-02-01', 1574.00, 0),
(3010, 1008, 'Auto',     'Paid Off',   28000.00,  0.00,      4.50, '2019-09-01', '2024-09-01', 522.00,  0),
-- Lisa Johnson - HIGH RISK
(3011, 1011, 'Personal', 'Delinquent', 8000.00,   7600.00,   15.00, '2023-03-01', '2026-03-01', 277.00,  60),
-- Carlos Garcia
(3012, 1012, 'Business', 'Active',     120000.00, 85000.00,  6.25, '2020-06-01', '2030-06-01', 1345.00, 0);

-- ===================== CREDIT SCORES =====================
INSERT INTO dbo.CreditScores (CreditScoreID, CustomerID, ScoreDate, Score, ScoreProvider, ScoreBand)
VALUES
-- Sarah Mitchell - Excellent
(4001, 1001, '2025-12-01', 812, 'FICO', 'Excellent'),
(4002, 1001, '2025-06-01', 805, 'FICO', 'Excellent'),
-- James Rodriguez - Fair (declining)
(4003, 1002, '2025-12-01', 640, 'FICO', 'Fair'),
(4004, 1002, '2025-06-01', 668, 'FICO', 'Fair'),
-- Emily Chen - Good
(4005, 1003, '2025-12-01', 745, 'FICO', 'Good'),
-- Michael Thompson - Poor (KEY DEMO CHARACTER)
(4006, 1004, '2025-12-01', 520, 'FICO', 'Poor'),
(4007, 1004, '2025-06-01', 558, 'FICO', 'Poor'),
(4008, 1004, '2025-01-01', 590, 'FICO', 'Fair'),
-- Aisha Patel - Good
(4009, 1005, '2025-12-01', 748, 'FICO', 'Good'),
-- David Kim - Poor (KEY DEMO CHARACTER)
(4010, 1006, '2025-12-01', 480, 'FICO', 'Poor'),
(4011, 1006, '2025-06-01', 510, 'FICO', 'Poor'),
-- Maria Santos - Excellent
(4012, 1007, '2025-12-01', 825, 'FICO', 'Excellent'),
-- Robert Williams - Good
(4013, 1008, '2025-12-01', 710, 'FICO', 'Good'),
-- Jennifer Brown - Good
(4014, 1009, '2025-12-01', 695, 'FICO', 'Good'),
-- Ahmed Hassan - Excellent
(4015, 1010, '2025-12-01', 790, 'FICO', 'Excellent'),
-- Lisa Johnson - Poor (KEY DEMO CHARACTER)
(4016, 1011, '2025-12-01', 535, 'FICO', 'Poor'),
(4017, 1011, '2025-06-01', 570, 'FICO', 'Fair'),
-- Carlos Garcia - Good
(4018, 1012, '2025-12-01', 720, 'FICO', 'Good');

-- ===================== TRANSACTIONS =====================
-- Key pattern: Michael Thompson (1004), David Kim (1006), Lisa Johnson (1011)
-- all have recent large transactions despite low credit scores
INSERT INTO dbo.Transactions (TransactionID, AccountID, TransactionDate, TransactionType, Amount, MerchantCategory, Description, Channel)
VALUES
-- Sarah Mitchell - Normal VIP activity
(5001, 2001, '2026-02-15 09:30:00', 'Deposit',    8500.00,  'Payroll',         'Direct deposit - salary',           'Online'),
(5002, 2001, '2026-02-16 14:20:00', 'Payment',    1958.00,  'Mortgage',        'Monthly mortgage payment',          'Online'),
(5003, 2001, '2026-02-18 11:45:00', 'Withdrawal', 250.00,   'ATM',             'ATM withdrawal',                    'ATM'),
(5004, 2002, '2026-02-10 08:00:00', 'Transfer',   5000.00,  'Internal',        'Transfer to investment',            'Mobile'),

-- James Rodriguez - Moderate activity
(5005, 2004, '2026-02-14 10:15:00', 'Deposit',    4200.00,  'Payroll',         'Direct deposit - salary',           'Online'),
(5006, 2004, '2026-02-15 16:30:00', 'Payment',    667.00,   'Auto Loan',       'Auto loan payment',                 'Online'),
(5007, 2004, '2026-02-17 13:00:00', 'Withdrawal', 1800.00,  'Retail',          'Electronics purchase',              'Branch'),

-- Michael Thompson - HIGH RISK: Large transactions, low credit, delinquent loans
(5008, 2008, '2026-02-10 22:15:00', 'Withdrawal', 12500.00, 'Wire Transfer',   'Outbound wire transfer',            'Online'),
(5009, 2008, '2026-02-12 03:45:00', 'Withdrawal', 8700.00,  'Wire Transfer',   'International wire transfer',       'Online'),
(5010, 2008, '2026-02-15 19:30:00', 'Deposit',    25000.00, 'Cash',            'Cash deposit at branch',            'Branch'),
(5011, 2008, '2026-02-18 14:00:00', 'Withdrawal', 15000.00, 'Wire Transfer',   'Outbound wire - investment',        'Online'),
(5012, 2008, '2026-02-20 08:30:00', 'Withdrawal', 11000.00, 'Cashier Check',   'Cashier check issued',              'Branch'),

-- Emily Chen - Normal activity
(5013, 2006, '2026-02-15 09:00:00', 'Deposit',    3800.00,  'Payroll',         'Direct deposit - salary',           'Online'),
(5014, 2006, '2026-02-16 12:00:00', 'Payment',    1200.00,  'Rent',            'Monthly rent payment',              'Online'),

-- Aisha Patel - Normal premium activity
(5015, 2009, '2026-02-14 08:30:00', 'Deposit',    6500.00,  'Payroll',         'Direct deposit - salary',           'Online'),
(5016, 2009, '2026-02-15 10:00:00', 'Payment',    1760.00,  'Mortgage',        'Monthly mortgage payment',          'Online'),
(5017, 2010, '2026-02-18 15:00:00', 'Transfer',   3000.00,  'Internal',        'Transfer to investment',            'Mobile'),

-- David Kim - HIGH RISK: Unusual large transactions
(5018, 2011, '2026-02-11 21:00:00', 'Withdrawal', 9500.00,  'Wire Transfer',   'Outbound wire transfer',            'Online'),
(5019, 2011, '2026-02-14 17:30:00', 'Deposit',    18000.00, 'Cash',            'Cash deposit',                      'Branch'),
(5020, 2011, '2026-02-16 23:45:00', 'Withdrawal', 16500.00, 'Wire Transfer',   'International wire',                'Online'),

-- Maria Santos - Normal VIP
(5021, 2012, '2026-02-15 09:30:00', 'Deposit',    12000.00, 'Payroll',         'Direct deposit - salary',           'Online'),
(5022, 2012, '2026-02-16 11:00:00', 'Payment',    2705.00,  'Mortgage',        'Monthly mortgage payment',          'Online'),
(5023, 2014, '2026-02-18 14:30:00', 'Transfer',   10000.00, 'Internal',        'Transfer to investment',            'Mobile'),

-- Robert Williams
(5024, 2015, '2026-02-15 09:00:00', 'Deposit',    5200.00,  'Payroll',         'Direct deposit - salary',           'Online'),
(5025, 2015, '2026-02-16 10:30:00', 'Payment',    1574.00,  'Mortgage',        'Monthly mortgage payment',          'Online'),

-- Jennifer Brown - New customer, small activity
(5026, 2017, '2026-02-15 09:15:00', 'Deposit',    2800.00,  'Payroll',         'Direct deposit - salary',           'Online'),
(5027, 2017, '2026-02-17 14:00:00', 'Withdrawal', 120.00,   'Dining',          'Restaurant payment',                'Mobile'),

-- Ahmed Hassan - VIP
(5028, 2018, '2026-02-14 09:00:00', 'Deposit',    15000.00, 'Payroll',         'Direct deposit - salary',           'Online'),
(5029, 2019, '2026-02-15 11:00:00', 'Transfer',   25000.00, 'Internal',        'Transfer to investment',            'Online'),

-- Lisa Johnson - HIGH RISK: Large transactions despite low credit
(5030, 2020, '2026-02-12 20:00:00', 'Deposit',    14000.00, 'Cash',            'Cash deposit',                      'Branch'),
(5031, 2020, '2026-02-13 22:30:00', 'Withdrawal', 13500.00, 'Wire Transfer',   'Outbound wire transfer',            'Online'),
(5032, 2020, '2026-02-17 16:00:00', 'Withdrawal', 10500.00, 'Wire Transfer',   'International wire',                'Online'),

-- Carlos Garcia - Business owner
(5033, 2021, '2026-02-10 08:00:00', 'Deposit',    22000.00, 'Business Income', 'Business revenue deposit',          'Online'),
(5034, 2021, '2026-02-15 10:00:00', 'Payment',    1345.00,  'Business Loan',   'Monthly business loan payment',     'Online'),
(5035, 2021, '2026-02-18 14:00:00', 'Withdrawal', 8500.00,  'Payroll',         'Staff payroll',                     'Online');

GO

PRINT 'Sample data seeded successfully.';
PRINT 'Total: 12 customers, 22 accounts, 12 loans, 18 credit scores, 35 transactions';
