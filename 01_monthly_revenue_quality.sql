/* For each month in 2017-2018, what was total revenue,
number of orders, average order value, and average review score?
Flag months where average review score dropped below 4.0 */

WITH
analysis AS (
    SELECT
        o.order_id AS order_id,
        strftime('%Y-%m', o.order_purchase_timestamp) AS purchase_month,
        p.payment_value,
        r.review_score
    FROM olist_orders_dataset o
    JOIN olist_order_reviews_dataset r
        ON o.order_id = r.order_id
    JOIN olist_order_payments_dataset p
        ON o.order_id = p.order_id
    WHERE 
        o.order_purchase_timestamp >= '2017-01-01'
        AND o.order_purchase_timestamp < '2019-01-01'
        AND o.order_status = 'delivered'
),
monthly AS (
SELECT
    COUNT(order_id) AS total_orders,
    purchase_month,
    ROUND(SUM(payment_value), 2) AS monthly_revenue,
    ROUND(AVG(payment_value), 2) AS average_order_value,
    ROUND(AVG(review_score), 2) AS average_review_score,
    CASE WHEN 
        AVG(review_score) < 4 
            THEN 'Low' ELSE 'High'
    END AS flag
FROM
    analysis
GROUP BY
    purchase_month
)
SELECT
    purchase_month,
    total_orders,
    printf('%,.2f', monthly_revenue) AS monthly_revenue,
    printf('%,.2f', average_order_value) AS average_order_value,
    average_review_score,
    flag,
    printf('%,.2f', SUM(monthly_revenue) OVER ()) AS grand_total
FROM
    monthly
ORDER BY
    purchase_month;
