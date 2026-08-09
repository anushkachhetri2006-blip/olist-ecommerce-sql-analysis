use Olist_Ecommerce;
-- Product analysis 
-- Highest revenue products
select
product_id , sum(price) as revenue
from olist_order_items_dataset 
group by product_id
order by revenue desc;

-- Best-selling categories by quantity
select
p.product_category_name, count(*) as unit_sold
from olist_products_dataset as p
inner join olist_order_items_dataset as i
on p.product_id = i.product_id
group by product_category_name
order by unit_sold desc;

-- Best-selling products 
select 
product_id,count(*) as unit_sold
from olist_order_items_dataset
group by product_id
order by unit_sold desc;

-- Average product price
select
round(avg(price),3) as average
from olist_order_items_dataset
order by average desc;