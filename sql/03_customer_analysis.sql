-- Repeat Customers

select
    count(*) as repeat_customers
from (
    select
        c.customer_unique_id,
        count(o.order_id) as orders_count
    from customers c
    join orders o
        on c.customer_id = o.customer_id
    group by c.customer_unique_id
    having count(o.order_id) > 1
) repeat_customers;

--Customer Segmentation

select
    case
        when orders_count = 1 then 'One-time Customer'
        when orders_count between 2 and 3 then 'Returning Customer'
        else 'Loyal Customer'
    end as customer_segment,
    count(*) as customers
from (
    select c.customer_unique_id,
        count(o.order_id) as orders_count
    from customers c
    join orders o
        on c.customer_id = o.customer_id
    group by c.customer_unique_id
    ) customer_orders
group by customer_segment
order by customers desc;

-- Average Orders per Customer

select
	round(avg(orders_count), 2) as avg_orders_per_customer
from (
		select c.customer_unique_id, 
			count(o.order_id) as orders_count
		from customers c
		join orders o
			on c.customer_id = o.customer_id
		group by c.customer_unique_id
) customer_orders;