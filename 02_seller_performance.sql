/* Rank sellers by total revenue in 2017. For each seller show: total revenue,
number of orders, average order value, average review score, and their rank within their state.
Flag sellers whose average review score is below 3.5. */

WITH seller_data AS (
SELECT 
    o.order_id id,
    i.product_id,
    i.seller_id seller,
    i.price revenue,
    r.review_score score,
    s.seller_state state
FROM
    olist_orders_dataset o
    JOIN olist_order_items_dataset i
        ON o.order_id = i.order_id
    JOIN olist_order_reviews_dataset r
        ON o.order_id = r.order_id
    JOIN olist_sellers_dataset s
        ON i.seller_id = s.seller_id
WHERE
    order_purchase_timestamp >= '2017-01-01'
    AND order_purchase_timestamp < '2018-01-01'
    AND order_status = 'delivered'
), seller_calc AS (
SELECT
    seller,
    state,
    COUNT (DISTINCT(id)) total_orders,
    ROUND(SUM(revenue), 2) total_revenue,
    ROUND(AVG(revenue), 2) avg_order_value,
    ROUND(AVG(score), 2) avg_rev_score,
    CASE
        WHEN AVG(score) < 3.5 
            THEN 'Low' ELSE 'Good' 
    END AS Flag
FROM
    seller_data
GROUP BY
    seller
)
SELECT
    seller,
    state,
    total_orders,
    printf('%,.2f', total_revenue) revenue,
    printf('%,.2f', avg_order_value) aov,
    avg_rev_score score,
    Flag,
    RANK() OVER
        (PARTITION BY 
            state 
        ORDER BY 
            total_revenue DESC
        ) ranking
FROM
    seller_calc
ORDER BY
    total_revenue DESC
