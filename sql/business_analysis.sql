
-- Bluestock Fintech MF Analytics Platform
-- SQL Business Analysis
-- Database: mf_analytics

USE mf_analytics;

-- 1. Top 10 schemes by 3-year returns
SELECT
    scheme_name,
    fund_house,
    category,
    return_3yr_pct
FROM scheme_performance
ORDER BY return_3yr_pct DESC
LIMIT 10;



-- 2. Category-wise average 3-year returns
SELECT
    category,
    COUNT(*) AS total_schemes,
    ROUND(AVG(return_3yr_pct), 2) AS avg_return_3yr_pct,
    ROUND(MAX(return_3yr_pct), 2) AS highest_return_3yr_pct,
    ROUND(MIN(return_3yr_pct), 2) AS lowest_return_3yr_pct
FROM scheme_performance
GROUP BY category
ORDER BY avg_return_3yr_pct DESC;


-- 3. Latest AUM ranking by fund house
SELECT
    fund_house,
    ROUND(aum_lakh_crore, 2) AS aum_lakh_crore,
    aum_crore,
    num_schemes,
    date
FROM aum_by_fund_house
WHERE date = (
    SELECT MAX(date)
    FROM aum_by_fund_house
)
ORDER BY aum_lakh_crore DESC;



-- 4. Monthly SIP inflow trend
SELECT
    month,
    sip_inflow_crore,
    active_sip_accounts_crore,
    new_sip_accounts_lakh,
    yoy_growth_pct
FROM monthly_sip_inflows
ORDER BY month;




-- 5. Transaction analysis by transaction type
SELECT
    transaction_type,
    COUNT(*) AS total_transactions,
    ROUND(
        SUM(CAST(amount_inr AS DECIMAL(15,2))) / 10000000,
        2
    ) AS total_amount_crore,
    ROUND(
        AVG(CAST(amount_inr AS DECIMAL(15,2))),
        2
    ) AS avg_transaction_amount_inr
FROM investor_transactions
GROUP BY transaction_type
ORDER BY total_amount_crore DESC;



-- 6. State-wise investor transaction analysis
SELECT
    state,
    COUNT(*) AS total_transactions,
    ROUND(
        SUM(CAST(amount_inr AS DECIMAL(15,2))) / 10000000,
        2
    ) AS total_amount_crore,
    ROUND(
        AVG(CAST(amount_inr AS DECIMAL(15,2))),
        2
    ) AS avg_transaction_amount_inr
FROM investor_transactions
GROUP BY state
ORDER BY total_amount_crore DESC;



-- 7. Investor transaction analysis by age group
SELECT
    age_group,
    COUNT(*) AS total_transactions,
    ROUND(
        SUM(CAST(amount_inr AS DECIMAL(15,2))) / 10000000,
        2
    ) AS total_amount_crore,
    ROUND(
        AVG(CAST(amount_inr AS DECIMAL(15,2))),
        2
    ) AS avg_transaction_amount_inr
FROM investor_transactions
GROUP BY age_group
ORDER BY total_amount_crore DESC;



-- 8. Investor transaction analysis by payment mode
SELECT
    payment_mode,
    COUNT(*) AS total_transactions,
    ROUND(
        SUM(CAST(amount_inr AS DECIMAL(15,2))) / 10000000,
        2
    ) AS total_amount_crore,
    ROUND(
        AVG(CAST(amount_inr AS DECIMAL(15,2))),
        2
    ) AS avg_transaction_amount_inr
FROM investor_transactions
GROUP BY payment_mode
ORDER BY total_amount_crore DESC;


-- 9. Investor transaction analysis by KYC status
SELECT
    kyc_status,
    COUNT(*) AS total_transactions,
    ROUND(
        SUM(CAST(amount_inr AS DECIMAL(15,2))) / 10000000,
        2
    ) AS total_amount_crore,
    ROUND(
        AVG(CAST(amount_inr AS DECIMAL(15,2))),
        2
    ) AS avg_transaction_amount_inr
FROM investor_transactions
GROUP BY kyc_status
ORDER BY total_transactions DESC;



-- 10. Risk and return analysis by mutual fund scheme
SELECT
    scheme_name,
    fund_house,
    category,
    ROUND(return_3yr_pct, 2) AS return_3yr_pct,
    ROUND(beta, 2) AS beta,
    risk_grade,
    ROUND(sharpe_ratio, 2) AS sharpe_ratio
FROM scheme_performance
ORDER BY return_3yr_pct DESC
LIMIT 10;



-- 11. Mutual fund returns compared with benchmarks
SELECT
    scheme_name,
    category,
    ROUND(return_3yr_pct, 2) AS fund_return_3yr_pct,
    ROUND(benchmark_3yr_pct, 2) AS benchmark_return_3yr_pct,
    ROUND(return_3yr_pct - benchmark_3yr_pct, 2) AS excess_return_pct
FROM scheme_performance
ORDER BY excess_return_pct DESC
LIMIT 10;



-- 12. Expense ratio versus 3-year returns
SELECT
    scheme_name,
    category,
    ROUND(expense_ratio_pct, 2) AS expense_ratio_pct,
    ROUND(return_3yr_pct, 2) AS return_3yr_pct,
    ROUND(benchmark_3yr_pct, 2) AS benchmark_3yr_pct
FROM scheme_performance
ORDER BY expense_ratio_pct DESC
LIMIT 10;



-- 13. Fund house performance comparison
SELECT
    fund_house,
    COUNT(*) AS total_schemes,
    ROUND(AVG(return_3yr_pct), 2) AS avg_return_3yr_pct,
    ROUND(MAX(return_3yr_pct), 2) AS highest_return_3yr_pct
FROM scheme_performance
GROUP BY fund_house
ORDER BY avg_return_3yr_pct DESC;



-- 14. Category-wise risk and return analysis
SELECT
    category,
    COUNT(*) AS total_schemes,
    ROUND(AVG(return_3yr_pct), 2) AS avg_return_3yr_pct,
    ROUND(AVG(beta), 2) AS avg_beta,
    ROUND(AVG(sharpe_ratio), 2) AS avg_sharpe_ratio
FROM scheme_performance
GROUP BY category
ORDER BY avg_return_3yr_pct DESC;



