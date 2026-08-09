--  for olist_customers_dataset
-- check for NULL values
use Olist_Ecommerce;
select 
sum(customer_id is null) as customer_id_null,
sum(customer_unique_id is null) as customer_unique_id_null,
sum(customer_zip_code_prefix is null) as customer_zip_code_prefix_null,
sum(customer_city is null) as customer_city_null,
sum(customer_state is null)as customer_state_null
from olist_customers_dataset;

-- checking for duplicate customer id
select customer_id,count(*) as duplicate_id
from olist_customers_dataset
group by customer_id
having count(*) > 1 ;

-- checking for empty string
select *
from olist_customers_dataset
where customer_city = '';
select *
from olist_customers_dataset
where customer_state = '';

-- to trim extra spaces
select *
from olist_customers_dataset 
where customer_city <> trim(customer_city);

select *
from olist_customers_dataset 
where customer_state <> trim(customer_state);

-- checking distinct values in the table
select distinct customer_state
from olist_customers_dataset;

-- for olist_geolocation_dataset
-- check for null values
select 
sum(geolocation_zip_code_prefix is null) as geolocation_zip_code_prefix_null,
sum(geolocation_lat is null)as geolocation_lat_null,
sum(geolocation_lng is null) as geolocation_lng_null,
sum(geolocation_city is null) as geolocation_city_null,
sum(geolocation_state is null) as geolocation_state_null
from olist_geolocation_dataset;

-- check for duplicate zip code
select geolocation_zip_code_prefix,geolocation_city,count(*) as geolocation_zip_code_prefix_duplicates
from olist_geolocation_dataset
group by geolocation_zip_code_prefix,geolocation_city
having count(*)>1;

-- check blank spaces
select geolocation_city
from olist_geolocation_dataset
where geolocation_city = '';

select geolocation_state
from olist_geolocation_dataset
where geolocation_state = '';

-- check for any extra spaces
select geolocation_city,geolocation_state
from olist_geolocation_dataset
where geolocation_city <> trim(geolocation_city) or geolocation_state <> trim(geolocation_state);

-- check for distinct values
select distinct(geolocation_state)
from olist_geolocation_dataset;

-- for olist_order_items_dataset
-- check for null 
select
sum(order_id is null) as order_id_null,
sum(order_item_id is null)as order_item_id_null,
sum(product_id is null)as product_id_null,
sum(seller_id is null)as seller_id_null,
sum(shipping_limit_date is null) as shipping_limit_date_null,
sum(price is null)as price_null,
sum(freight_value is null) as freight_value_null
from olist_order_items_dataset;

-- check for duplicate values
select order_id ,order_item_id,count(*) as duplicate_order_id
from olist_order_items_dataset
group by order_id,order_item_id
having count(*)>1;

-- check for empty values
select product_id,seller_id
from olist_order_items_dataset
where product_id = '' or seller_id = '';
-- check if prices are negative
select price
from olist_order_items_dataset
where price<0; 

-- check if freight value is negative
select freight_value
from olist_order_items_dataset
where freight_value <0; 

-- to check the min,max,avg prices
select min(price)as min_price,
max(price) as max_price,
avg(price) as avg_price
from olist_order_items_dataset;

-- check min,max,avg freight value
select min(freight_value) as min_freight_value,
max(freight_value) as max_frieght_value,
avg(freight_value) as avg_freight_value
from olist_order_items_dataset;

-- check seller availability(25 missing)
select count(*) as missing_sellers_ids
from olist_order_items_dataset as o
left join olist_sellers_dataset as s
on o.seller_id = s.seller_id
where s.seller_id is null

 -- check if product _id is available for each record(26 missing)
 select count(*) as misssing_product_ids
 from olist_order_items_dataset as o
 left join olist_products_dataset as p
 on o.product_id = p.product_id
 where p.product_id is null;
 
 select distinct o.product_id
 from olist_order_items_dataset as o
 left join olist_products_dataset as p
 on o.product_id = p.product_id
 where p.product_id is null;
 
-- for olist_order_payments_dataset
-- check the null values
select
sum(order_id is null) as order_id_null,
sum(payment_sequential is null) as payment_sequential_null,
sum(payment_type is null) as payment_type_null,
sum(payment_installments is null)as payment_installments_null,
sum(payment_value is null ) as payment_value_null
from olist_order_payments_dataset;

-- check for duplicate values
select order_id,payment_sequential,count(*) as duplicate_order_id
from olist_order_payments_dataset
group by order_id,payment_sequential
having count(*)>1

-- check if payment_value is negative 
select payment_value
from olist_order_payments_dataset
where payment_value<0;

-- check distinct payment type
select distinct (payment_type)
from olist_order_payments_dataset;

-- check order_id availability
select o.order_id
from olist_order_payments_dataset as o
inner join olist_orders_dataset as ord
on o.order_id = ord.order_id
where ord.order_id is null;

-- for olist_reviews_dataset
-- check for null values
select
sum(review_id is null) as review_id_null, 
sum(order_id is null) as order_id_null,
sum(review_score is null) as review_score_null,
sum(review_comment_title is null) as review_comment_title_null,
sum(review_comment_message is null) as review_comment_message_null,
sum(review_creation_date is null) as review_creation_date_null,
sum(review_answer_timestamp is null) as review_answer_timestamp_null
from olist_order_reviews_dataset;

-- check for duplicate values
select review_id,count(*) as review_id
from olist_order_reviews_dataset
group by review_id
having count(*) > 1;

select order_id,count(*) as order_id
from olist_order_reviews_dataset
group by order_id
having count(*) > 1;

-- check the range of review_score
select review_score
from olist_order_reviews_dataset
where review_score not between 1 and 5;

-- check the blank space 
select review_comment_title
from olist_order_reviews_dataset
where review_comment_title = '';

select review_comment_message
from olist_order_reviews_dataset
where review_comment_message = '';

-- for olist_order_dataset
-- check for null values
select
sum(order_id is null)as order_id_null,
sum(customer_id is null)as customer_id_null,
sum(order_status is null)as order_status_null,
sum(order_purchase_timestamp is null)as order_purchase_timestamp_null,
sum(order_approved_at is null)as order_approved_at_null,
sum(order_delivered_carrier_date is null)as order_delivered_carrier_date_null,
sum(order_delivered_customer_date is null)as order_delivered_customer_date_null,
sum(order_estimated_delivery_date is null)as order_estimated_delivery_date_null
from olist_orders_dataset;

-- check for duplicate values 
select order_id,count(*) as duplicate_order_id
from olist_orders_dataset
group by order_id
having count(*) >1;

select customer_id,count(*) as duplicate_customer_id
from olist_orders_dataset
group by customer_id
having count(*) >1;

-- check for blank values
select order_status
from olist_orders_dataset
where order_status = '';

-- check for distinct value in status
select distinct order_status
from olist_orders_dataset;

-- check consistently formatted
select *
from olist_orders_dataset
where str_to_date(order_approved_at, '%y-%m-%d %h:%i:%s') < str_to_date (order_purchase_timestamp, '%y-%m-%d %h:%i:%s');
-- check delivery date should be on or after purchase
select count(*)
from olist_orders_dataset
where order_estimated_delivery_date <order_purchase_timestamp; 
-- check with same format
SELECT *
FROM olist_orders_dataset
WHERE DATE(STR_TO_DATE(order_estimated_delivery_date, '%Y-%m-%d %H:%i:%s'))
      <
      DATE(STR_TO_DATE(order_purchase_timestamp, '%Y-%m-%d %H:%i:%s'));
      
      
-- for olist_products_dataset
-- check for null
select
sum(product_id is null) as product_id_null,
sum(product_category_name is null)as product_category_name_null,
sum(product_name_lenght is null)as product_name_lenght_null,
sum(product_description_lenght is null)as product_description_lenght_null,
sum(product_photos_qty is null) as product_photos_qty_null,
sum(product_weight_g is null)as product_weight_g_null,
sum(product_length_cm is null) as product_length_cm_null,
sum(product_height_cm is null) as product_height_cm_null,
sum(product_width_cm is null) as product_width_cm_null
from olist_products_dataset;

-- check for duplicate values
select product_id,count(*)
from olist_products_dataset
group by product_id
having count(*)>1;

-- check product_id existence
 select o.product_id
 from olist_products_dataset as o
 inner join olist_order_items_dataset as i
 on o.product_id = i.product_id
 where i.product_id is null;
 
 -- check for blank values
 select product_category_name
 from olist_products_dataset
 where product_category_name = '';
 
 -- check if weight in negative
 select product_weight_g
 from olist_products_dataset
 where product_weight_g <0;
 
 -- check for bad quality photo
 select product_photos_qty
 from olist_products_dataset
 where product_photos_qty = 'poor' or 'bad';
 
 -- for olist_sellers_dataset
 -- check for null values 
 select
sum(seller_id is null) as seller_id_null, 
sum(seller_zip_code_prefix is null) as seller_zip_code_prefix_null,
sum(seller_city is null) as seller_city_null,
sum(seller_state is null) as seller_state_null
from olist_sellers_dataset;

-- check for duplicates values
select seller_id,seller_city,count(*) as same_zip_code
from olist_sellers_dataset
group by seller_id,seller_city
having seller_id >1;

-- check for seller_id existence
select o.seller_id
from olist_sellers_dataset as o
inner join olist_order_items_dataset as i
on o.seller_id = i.seller_id
where i.seller_id is null;

-- check for blank values
select seller_city
from olist_sellers_dataset
where seller_city ='';

select seller_state
from olist_sellers_dataset
where seller_state ='';

-- check distinct values
select distinct seller_state
from olist_sellers_dataset

-- for product_category_name_tra
-- check for null values
select
sum(ï»¿product_category_name is null) as ï»¿product_category_name_null,
sum(product_category_name_english is null) as product_category_name_english_null
from product_category_name_translation;

-- check distinct category
select distinct product_category_name_english
from product_category_name_translation;

-- check for blank values
select product_category_name_english
from product_category_name_translation
where product_category_name_english = '';


 









 


