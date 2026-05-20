/* For the top 10 product categories by order volume, calculate the percentage of orders
that were delivered vs cancelled. Use English category names. Flag categories with above-average
cancellation rates. */

WITH raw AS (
        SELECT
            p.product_category_name raw_name,
            n.product_category_name_english name,
            ROW_NUMBER() OVER (ORDER BY COUNT(o.order_id) DESC) AS rn,
            COUNT(o.order_id) total_orders,
            COUNT(CASE WHEN ord.order_status = 'delivered' THEN 1 END) delivered,
            COUNT(CASE WHEN ord.order_status = 'canceled' THEN 1 END) canceled
        FROM
            olist_order_items_dataset o
            JOIN olist_products_dataset p
                ON o.product_id = p.product_id
            JOIN product_category_name_translation n
                ON p.product_category_name = n.product_category_name
            JOIN olist_orders_dataset ord
                ON o.order_id = ord.order_id
        GROUP BY
            p.product_category_name
    ),
clean AS (
SELECT
    name,
    total_orders,
    delivered,
    canceled,
    ROUND(100.0 * delivered / total_orders, 2) p_delivered,
    ROUND(100.0 * canceled / total_orders, 2) p_canceled
FROM
    raw
WHERE rn <= 10
)
SELECT 
    *,
    CASE 
        WHEN p_canceled > AVG(p_canceled) OVER() THEN 'Critical'
        ELSE 'Normal'
    END AS Flag
FROM
    clean

