WITH stg_order_location AS (
    SELECT
        l.product_id,
        l.product_price,
        i.location_id
    FROM stg_orders AS i
    INNER JOIN order_items AS l
        ON i.order_id = l.order_id
    
)

SELECT
    i.product_id,
    COUNT(i.product_id) AS product_count,
    AVG(i.product_price* (1+l.tax_rate)) AS avg_product_price_with_tax
FROM stg_order_location AS i
INNER JOIN stg_locations AS l
    ON i.location_id = l.location_id
GROUP BY 1