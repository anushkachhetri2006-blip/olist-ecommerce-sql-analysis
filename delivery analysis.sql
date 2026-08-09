use Olist_Ecommerce;
-- delivery analysis
-- average delivery time
select
avg(datediff(order_delivered_customer_date,order_purchase_timestamp)) as avg_delivery_days
from olist_orders_dataset
where order_delivered_customer_date is not null ;

-- Orders delivered late
select 
count(*) as orders_delivered_late
from olist_orders_dataset
where order_delivered_customer_date>order_estimated_delivery_date;

-- Fastest sellers
select
i.seller_id,
avg(datediff(str_to_date(order_delivered_customer_date , '%Y-%m-%d %H:%i:%s'),str_to_date(order_purchase_timestamp, '%Y-%m-%d %H:%i:%s'))) as avg_delivery_days
from olist_order_items_dataset as i
inner join olist_orders_dataset as o
on i.order_id = o.order_id
where order_delivered_customer_date is not null 
group by i.seller_id
having avg_delivery_days is not null
ORDER BY avg_delivery_days ASC;