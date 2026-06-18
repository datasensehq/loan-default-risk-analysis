-- ============================================================
-- NovaCred Bank | Loan Default Risk Analysis
-- Query 3: Monthly Default Rate Trend
-- ============================================================
-- Purpose: Show how default rates have changed over time
-- Use:     Trend line chart in executive dashboard
-- ============================================================

SELECT
    issue_year,
    issue_month,
    COUNT(*)                                                  AS total_loans,
    SUM(default)                                              AS total_defaults,
    ROUND(100.0 * SUM(default) / COUNT(*), 2)                AS default_rate_pct,
    ROUND(SUM(loan_amnt), 0)                                  AS total_loan_volume
FROM loans
WHERE issue_year IS NOT NULL
GROUP BY issue_year, issue_month
ORDER BY issue_year, issue_month;

-- Expected insight: rising default rate from late 2015 onward
