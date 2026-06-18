-- ============================================================
-- NovaCred Bank | Loan Default Risk Analysis
-- Query 1: Default Rate by Credit Grade
-- ============================================================
-- Purpose: Identify which credit grades carry the highest risk
-- Use:     Executive summary + Power BI Grade segment page
-- ============================================================

SELECT
    grade,
    COUNT(*)                                                  AS total_loans,
    SUM(default)                                              AS total_defaults,
    ROUND(100.0 * SUM(default) / COUNT(*), 2)                AS default_rate_pct,
    ROUND(AVG(int_rate), 2)                                   AS avg_interest_rate,
    ROUND(AVG(loan_amnt), 0)                                  AS avg_loan_amount,
    ROUND(AVG(annual_inc), 0)                                 AS avg_annual_income
FROM loans
GROUP BY grade
ORDER BY grade;

-- Expected insight: Grade F & G will show default rates 30-35%
--                  vs Grade A at ~5-7%
