-- ============================================================
-- NovaCred Bank | Loan Default Risk Analysis
-- Query 4: High-Risk Segment Deep Dive
-- ============================================================
-- Purpose: Profile the specific borrower profiles most at risk
-- Use:     Risk mitigation recommendations slide
-- ============================================================

SELECT
    grade,
    purpose,
    COUNT(*)                                                  AS total_loans,
    ROUND(100.0 * SUM(default) / COUNT(*), 2)                AS default_rate_pct,
    ROUND(AVG(loan_amnt), 0)                                  AS avg_loan_size,
    ROUND(AVG(dti), 2)                                        AS avg_dti,
    ROUND(AVG(int_rate), 2)                                   AS avg_int_rate,
    ROUND(AVG(loan_to_income), 4)                             AS avg_loan_to_income
FROM loans
WHERE grade IN ('E','F','G')
  AND default = 1
GROUP BY grade, purpose
HAVING total_loans >= 50                -- only statistically significant groups
ORDER BY default_rate_pct DESC
LIMIT 15;

-- Expected insight: Grade F/G small_business loans are the most dangerous segment
