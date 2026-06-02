-- Total Revenue

select
    round(sum(price), 2) as total_revenue
from order_items;

-- Total Freight Revenue

SELECT
    round(sum(freight_value), 2) as total_freight
FROM order_items;

-- Average Order Value

select
    round(avg(order_value),2) as average_order_value
from (
    SELECT
        order_id, sum(price) as order_value
    from order_items
    group by order_id
)

--Top 10 Revenue Categories

select
    p.product_category_name, round(sum(oi.price),2) as revenue
from order_items oi 
join products p
    on oi.product_id = p.product_id
group by p.product_category_name
order by revenue desc
limit 10;

-- Monthly Revenue Trend

select
    date_trunc('month', o.order_purchase_timestamp) as month,
    round(sum(oi.price), 2) as revenue
from orders o
join order_items oi
    on o.order_id = oi.order_id
group by month
order by month

