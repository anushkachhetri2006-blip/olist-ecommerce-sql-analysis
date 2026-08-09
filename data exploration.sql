create database Olist_Ecommerce
use Olist_Ecommerce;
-- to check all the tables columns,rows,values
SELECT * FROM olist_ecommerce.olist_customers_dataset;
SELECT * FROM olist_ecommerce.olist_geolocation_dataset;
SELECT * FROM olist_ecommerce.olist_order_items_dataset;
SELECT * FROM olist_ecommerce.olist_order_payments_dataset;
SELECT * FROM olist_ecommerce.olist_order_reviews_dataset;
SELECT * FROM olist_ecommerce.olist_orders_dataset;
SELECT * FROM olist_ecommerce.olist_products_dataset;
SELECT * FROM olist_ecommerce.olist_sellers_dataset;
SELECT * FROM olist_ecommerce.product_category_name_translation;
-- to check the total count of rows in all tables
select count(*) as totalcustomers from olist_customers_dataset;
select count(*) as total_geolocations from olist_geolocation_dataset;
select count(*) as totalorder_items from olist_order_items_dataset;
select count(*) as total_payments from olist_order_payments_dataset;
select count(*) as total_reviews from olist_order_reviews_dataset;
select count(*) as total_orders from olist_orders_dataset;
select count(*) as total_products from olist_products_dataset;
select count(*) as total_sellers from olist_sellers_dataset;
select count(*) as total_productcategory from product_category_name_translation;
-- to check the all the info about all the tables
desc olist_customers_dataset;
desc olist_geolocation_dataset;
desc olist_order_payments_dataset;
desc olist_order_reviews_dataset;
desc olist_orders_dataset;
desc olist_products_dataset;
desc olist_sellers_dataset;
desc product_category_name_translation;


