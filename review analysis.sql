use Olist_Ecommerce;
-- review analysis
-- Average review score by category
select 
p.product_category_name,
avg(n.review_score) as avg_score
from olist_products_dataset as p
inner join olist_order_items_dataset as i
on p.product_id = i.product_id
inner join olist_order_reviews_dataset as n
on i.order_id = n.order_id
group by product_category_name
order by avg_score desc;

-- Relationship between delivery time and review score
select
o.order_id,
datediff(str_to_date(o.order_delivered_customer_date , '%Y-%m-%d %H:%i:%s'), str_to_date(o.order_purchase_timestamp,'%Y-%m-%d %H:%i:%s')) as delivery_date,
r.review_score
from olist_orders_dataset as o
inner join olist_order_reviews_dataset as r
on o.order_id = r.order_id
where o.order_delivered_customer_date  is not null
order by delivery_date;