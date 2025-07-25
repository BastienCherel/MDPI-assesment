WITH total_amount_per_month AS (
    SELECT
        orders.customer_id,
        customers.customer_name,
        DATE_TRUNC('month', orders.ordered_at) AS month,
        SUM(subtotal) AS total_amount
    FROM orders
    JOIN customers
        ON orders.customer_id = customers.customer_id
    GROUP BY 3, 2, 1
    ORDER BY 
        month ASC
),

total_amount_per_month_ranked AS (
    SELECT
        customer_id,
        customer_name,
        month,
        total_amount,
        RANK() OVER (PARTITION BY month ORDER BY total_amount DESC) AS rank
    FROM total_amount_per_month
)


SELECT
    customer_name,
    month,
    total_amount,
    rank
FROM total_amount_per_month_ranked
WHERE rank <= 3