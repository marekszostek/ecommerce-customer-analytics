-- Late Deliveries

select 
    count(*) as late_deliveries
from orders
where order_delivered_customer_date > order_estimated_delivery_date;

-- Delivery Performance

select
    round
    (100 * sum(
                case 
                    when order_delivered_customer_date <= order_estimated_delivery_date then 1
                    else 0
                end) / count(*), 2) as on_time_delivery_rate
from orders
where order_delivered_customer_date is not null

--Review Score by Delivery Status

select
	case
		when o.order_delivered_customer_date >
		o.order_estimated_Delivery_date
		then 'Late Delivery'
		else 'On-time Delivery'
	end as delivery_status,
	round(avg(r.review_score),2) as avg_reveiw_score
from orders o
join reviews r
	on o.order_id = r.order_id
where o.order_delivered_customer_date is not null
group by delivery_status