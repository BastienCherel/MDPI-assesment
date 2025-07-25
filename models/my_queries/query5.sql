SELECT
    supply_id,
    product_id,
    SUM(supply_cost) AS total_supply_cost
FROM supplies
GROUP BY 1, 2
