-- Record Count Validation

select 'customers' as table_name, count(*) as record_count 
from customers
union all
select 'orders', count(*) 
from orders
union all
select 'products', count(*)
from products
union all
select 'order_items', count(*)
from order_items
union all
select 'payments', count(*)
from payments  
union all
select 'reviews', count(*)
from reviews;

-- Missing Values Check

select 
    sum(case when customer_unique_id is null then 1 else 0 end) as missing_customer_unique_id
from customers;

select
    sum(case when order_purchase_timestamp is null then 1 else 0) as missing_order_date
from orders;

select
    sum(case when product_category_name is null then 1 else 0) as missing_product_category
from products;

--Duplicate Order IDs

select
    order_id,
    count(*)
from orders
group by order_id
having count(*) > 1;

-- Duplicate Review IDs

select
    review_id,
    count(*)
from reviews
group by review_id
having count(*) > 1
order by count(*) desc;