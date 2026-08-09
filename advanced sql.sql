use Olist_Ecommerce;
-- advanced sql
-- running total of revenue ( use of common table expression CTE)
with monthly_revenue as(
select
date_format(str_to_date(o.order_purchase_timestamp, '%Y-%m-%d %H:%i:%s') , '%Y-%m') as months,
round(sum(p.payment_value),2)as revenue
from olist_order_payments_dataset as p
inner join olist_orders_dataset as o
on p.order_id = o.order_id
group by months
)
select
months,
revenue,
round(sum(revenue) over(order by months),2) as running_total
from monthly_revenue
group by months;

-- Monthly growth %
with monthly_growth as(
select
date_format(str_to_date( o.order_purchase_timestamp, '%Y-%m-%d %H:%i:%s'), '%Y-%m') as year_months,
round(sum(p.payment_value),2) as revenue
from olist_orders_dataset as o
inner join olist_order_payments_dataset as p
on o.order_id = p.order_id
group by year_months
)
select
year_months,
revenue,
round((revenue-lag(revenue)over(order by year_months))/lag(revenue)over(order by year_months) *100,2) as monthly_growth_percentage
from monthly_growth
order by year_months;

-- Top 5 products per category(using CTE)
with product_revenue as (
select
i.product_id,
p.product_category_name,
round(sum(i.price),2) as revenue
from olist_order_items_dataset as i
inner join olist_products_dataset as p
on i.product_id = p.product_id
group by p.product_category_name,i.product_id)
,
ranked_product as (
select
product_id,
product_category_name,
revenue,
row_number()over(partition by product_category_name order by revenue desc) as product_rank
from product_revenue
)
select
product_id,
product_category_name,
revenue,
product_rank
from ranked_product
where product_rank <= 5
order by product_rank,product_category_name;

-- customer ranking
with total_spending as (
select
customer_unique_id,
sum(p.payment_value) as total_spend
from olist_customers_dataset as c
inner join olist_orders_dataset as o
on c.customer_id = o.customer_id
inner join olist_order_payments_dataset as p
on p.order_id = o.order_id
group by customer_unique_id )
select 
customer_unique_id,
total_spend,
rank() over(order by total_spend ) as ranks 
from total_spending
order by total_spend;

-- Revenue contribution (%) (using CTE)
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
order by revenue_contribution_percentage desc;














