-- 1. Total Customer Payment Value
SELECT
    ROUND(SUM(payment_value), 2) AS total_customer_payment_value
FROM olist_order_payments_dataset;

-- 2. Highest Revenue Month and year
select 
date_format(order_purchase_timestamp  , '%Y-%m') as months,
round(sum(payment_value),2) as total_revenue
from olist_orders_dataset as o
inner join olist_order_payments_dataset as p
on o.order_id = p.order_id
group by  months
order by total_revenue desc
limit 1;

-- Top customer revenue contribution:
select
c.customer_unique_id,sum(i.price) as revenue
from olist_customers_dataset as c
inner join olist_orders_dataset as o
on c.customer_id = o.customer_id
inner join olist_order_items_dataset as i
on o.order_id = i.order_id
group by c.customer_unique_id
order by revenue desc
limit 1;

-- Number of repeat customers:
SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT
        c.customer_unique_id
    FROM olist_customers_dataset AS c
    INNER JOIN olist_orders_dataset AS o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
    HAVING COUNT(DISTINCT o.order_id) > 1
) AS repeat_customer_list;

-- Average order value:
select
round(sum(price)/count(distinct(order_id)),2) as avg_order_value
from olist_order_items_dataset;

-- Highest-revenue category:
SELECT
    p.product_category_name,
    ROUND(SUM(i.price), 2) AS total_revenue
FROM olist_products_dataset AS p
INNER JOIN olist_order_items_dataset AS i
    ON p.product_id = i.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 1;
--  Highest-revenue product/category contribution:
with total_revenue as(
select
p.product_category_name , round(sum(i.price),2) as revenue
from olist_order_items_dataset as i
inner join olist_products_dataset as p
on i.product_id = p.product_id
group by p.product_category_name
)
select
product_category_name,
revenue,
round(revenue/sum(revenue)over() *100,2) as revenue_contribution_percentage
from total_revenue
order by revenue_contribution_percentage desc
limit 1;

-- Average delivery time:
select
avg(datediff(order_delivered_customer_date,order_purchase_timestamp)) as avg_delivery_days
from olist_orders_dataset
where order_delivered_customer_date is not null ;

-- Percentage of late deliveries:
SELECT
    ROUND(
        SUM(order_delivered_customer_date > order_estimated_delivery_date) * 100.0
        / COUNT(*),
        2
    ) AS late_delivery_percentage
FROM olist_orders_dataset
WHERE order_status = 'delivered';

-- Average review score:
SELECT
    ROUND(AVG(review_score), 2) AS average_review_score
FROM olist_order_reviews_dataset;

-- Lowest-rated category:
SELECT
    p.product_category_name,
    ROUND(AVG(r.review_score), 2) AS average_review_score
FROM olist_order_reviews_dataset AS r
INNER JOIN olist_orders_dataset AS o
    ON r.order_id = o.order_id
INNER JOIN olist_order_items_dataset AS i
    ON o.order_id = i.order_id
INNER JOIN olist_products_dataset AS p
    ON i.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
ORDER BY average_review_score ASC
LIMIT 1;


SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT
        c.customer_unique_id
    FROM olist_customers_dataset AS c
    INNER JOIN olist_orders_dataset AS o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
    HAVING COUNT(DISTINCT o.order_id) > 1
) AS repeat_customer_list;

-- late and on time delivery
SELECT
    CASE
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
        THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status,
    ROUND(AVG(r.review_score), 2) AS average_review_score
FROM olist_orders_dataset AS o
INNER JOIN olist_order_reviews_dataset AS r
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY delivery_status;

-- Which categories receive the highest customer ratings
SELECT
    p.product_category_name,
    ROUND(AVG(r.review_score), 2) AS average_review_score
FROM olist_order_reviews_dataset AS r
INNER JOIN olist_orders_dataset AS o
    ON r.order_id = o.order_id
INNER JOIN olist_order_items_dataset AS i
    ON o.order_id = i.order_id
INNER JOIN olist_products_dataset AS p
    ON i.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
ORDER BY average_review_score DESC
LIMIT 5;

-- What percentage of total revenue comes from top customers or products
SELECT
    c.customer_unique_id,
    ROUND(SUM(p.payment_value), 2) AS total_revenue
FROM olist_order_payments_dataset AS p
INNER JOIN olist_orders_dataset AS o
    ON o.order_id = p.order_id
INNER JOIN olist_customers_dataset AS c
    ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
ORDER BY total_revenue DESC
LIMIT 10;
