use Olist_Ecommerce;
-- customer analysis
-- Top 10 customers by spending
select 
round(sum(p.payment_value),2) as total_revenue,
c.customer_id as customers
from olist_order_payments_dataset as p
inner join olist_orders_dataset as o 
on o.order_id = p.order_id 
inner join olist_customers_dataset as c
on c.customer_id = o.customer_id
group by customers
order by total_revenue desc
limit 10;

-- repeat customers
select
c.customer_unique_id,
count(o.order_id) as order_count
from olist_customers_dataset as c
inner join olist_orders_dataset as o
on c.customer_id = o.customer_id
group by customer_unique_id
having count(o.order_id)>1
order by order_count desc;

-- Average order value 
select
round(sum(price)/count(distinct(order_id)),2) as avg_order_value
from olist_order_items_dataset;

-- Customer lifetime value(product revenue generated)
select
c.customer_unique_id,sum(i.price) as revenue
from olist_customers_dataset as c
inner join olist_orders_dataset as o
on c.customer_id = o.customer_id
inner join olist_order_items_dataset as i
on o.order_id = i.order_id
group by c.customer_unique_id
order by revenue desc;