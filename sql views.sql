-- customer revenue
create view customer_revenue as
select
c.customer_unique_id,sum(i.price) as revenue
from olist_customers_dataset as c
inner join olist_orders_dataset as o
on c.customer_id = o.customer_id
inner join olist_order_items_dataset as i
on o.order_id = i.order_id
group by c.customer_unique_id
order by revenue desc;
-- testing
SELECT *
FROM customer_revenue
ORDER BY revenue DESC;

-- monthly revenue
create view monthly_revenue as
select 
date_format(str_to_date(o.order_purchase_timestamp,'%Y-%m-%d %H:%i:%s' ),'%Y-%m') as year_months,
round(sum(p.payment_value),2) as total_revenue
from olist_orders_dataset as o
inner join olist_order_payments_dataset as p
on o.order_id = p.order_id
group by year_months
order by year_months;
-- testing
select *
from monthly_revenue;

-- product category revenue
create view product_category_revenue as
select
p.product_category_name, count(*) as unit_sold
from olist_products_dataset as p
inner join olist_order_items_dataset as i
on p.product_id = i.product_id
group by product_category_name
order by unit_sold desc;
-- testing
select *
from product_category_revenue;

-- 