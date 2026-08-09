use Olist_Ecommerce;
-- payment analysis
-- most used payment method 
select
payment_type,
count(*) as number_of_payments
from olist_order_payments_dataset
group by payment_type
order by number_of_payments desc
limit 1;

-- Installment analysis
-- most common installment number
select
payment_installments,
count(*) as number_of_installment
from olist_order_payments_dataset
group by payment_installments
order by number_of_installment desc;

-- most common type of payment type
select 
payment_type,
round(avg(payment_installments),2) as avg_payment_installments
from olist_order_payments_dataset
group by payment_type
order by avg_payment_installments desc;