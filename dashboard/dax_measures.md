# Power BI DAX Measures — NovaCred Bank Dashboard

All measures go under **Modeling → New Measure** in Power BI Desktop.
Table name assumed: `loans`

---

## Core KPIs

```dax
Total Loans = COUNT(loans[loan_amnt])

Total Defaults = SUM(loans[default])

Default Rate % =
    DIVIDE([Total Defaults], [Total Loans], 0) * 100

Total Loan Volume = SUM(loans[loan_amnt])

Avg Interest Rate = AVERAGE(loans[int_rate])

Avg DTI = AVERAGE(loans[dti])

Avg Risk Score = AVERAGE(loans[risk_score])
```

---

## Risk Tier Measures

```dax
High Risk Count =
    CALCULATE(COUNT(loans[loan_amnt]), loans[risk_tier] = "High")

High Risk Volume ($) =
    CALCULATE(SUM(loans[loan_amnt]), loans[risk_tier] = "High")

High Risk Share % =
    DIVIDE([High Risk Count], [Total Loans], 0) * 100

Medium Risk Count =
    CALCULATE(COUNT(loans[loan_amnt]), loans[risk_tier] = "Medium")

Low Risk Count =
    CALCULATE(COUNT(loans[loan_amnt]), loans[risk_tier] = "Low")
```

---

## Time Intelligence

```dax
YoY Default Rate Change =
    VAR CurrentRate = [Default Rate %]
    VAR PriorRate = CALCULATE([Default Rate %], DATEADD(loans[issue_d], -1, YEAR))
    RETURN CurrentRate - PriorRate

Rolling 3M Default Rate =
    CALCULATE([Default Rate %], DATESINPERIOD(loans[issue_d], LASTDATE(loans[issue_d]), -3, MONTH))
```

---

## Conditional Formatting Measures

```dax
Default Rate Color =
    SWITCH(
        TRUE(),
        [Default Rate %] >= 25, "#e74c3c",   -- Red: High
        [Default Rate %] >= 15, "#f39c12",   -- Orange: Medium
        "#2ecc71"                             -- Green: Low
    )
```

---

## Dashboard Page Structure

### Page 1 — Executive Summary
- KPI cards: Total Loans, Default Rate %, Total Volume, Avg Risk Score
- Line chart: Quarterly default rate trend (issue_d on X-axis)
- Bar chart: Default rate by grade
- Slicer: Year, Grade

### Page 2 — Segment Deep Dive
- Bar chart: Top 10 purposes by default rate
- Scatter: DTI vs Risk Score (colored by Risk Tier)
- Table: Grade × Purpose default matrix
- Slicer: Purpose, Grade, Risk Tier

### Page 3 — Risk Scoring View
- Donut chart: Portfolio by Risk Tier (Low / Medium / High)
- Bar: Avg Risk Score by Grade
- Table: Top 20 highest-risk loans (sorted by risk_score desc)
- KPI card: High Risk Volume ($)
