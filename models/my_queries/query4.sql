WITH monthly_totals AS (
    SELECT
        DATE_TRUNC('month', o.ordered_at) AS month,
        SUM(order_total) AS total_amount
    FROM orders o
    GROUP BY 1
    ORDER BY month ASC  
),

-- COMPUTE THE DIFFERENCE IN TOTAL AMOUNT BETWEEN MONTHS
variation AS (
    SELECT
        month,
        total_amount,
        LAG(total_amount) OVER (ORDER BY month) AS prev_total_amount
    FROM monthly_totals
)

SELECT
    month,
    total_amount,
    ROUND(
        ((total_amount - prev_total_amount) / prev_total_amount) * 100,
        2
    ) AS variation_percent
FROM variation
WHERE prev_total_amount IS NOT NULL
