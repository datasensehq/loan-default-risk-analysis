-- ============================================================
-- NovaCred Bank | Loan Default Risk Analysis
-- Query 2: Default Rate by Loan Purpose
-- ============================================================
-- Purpose: Find which loan use-cases carry highest default risk
-- Use:     Segment deep-dive dashboard page
-- ============================================================

SELECT
    purpose,
    COUNT(*)                                                  AS total_loans,
    SUM(default)                                              AS total_defaults,
    ROUND(100.0 * SUM(default) / COUNT(*), 2)                AS default_rate_pct,
    ROUND(AVG(loan_amnt), 0)                                  AS avg_loan_size,
    ROUND(AVG(dti), 2)                                        AS avg_dti
FROM loans
GROUP BY purpose
ORDER BY default_rate_pct DESC
LIMIT 10;

-- Expected insight: small_business typically tops the list
