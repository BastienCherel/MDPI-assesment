WITH items_per_order AS (
    SELECT
        o.location_id,
        o.order_id,
        COUNT(oi.product_id) AS item_count
    FROM stg_orders AS o
    INNER JOIN stg_order_items AS oi
        ON o.order_id = oi.order_id
    GROUP BY 1, 2
)

SELECT
    l.location_id,
    l.location_name,
    AVG(i.item_count) AS avg_items_per_order
FROM items_per_order AS i
INNER JOIN stg_locations AS l
    ON i.location_id = l.location_id
GROUP BY 1, 2
