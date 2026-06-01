-- Top 10 Categories by Revenue

select 
	p.product_category_name,
	round(sum(oi.price), 2) as revenue
from order_items oi
join products p
	on oi.product_id = p.product_id
group by p.product_category_name
order by revenue desc
limit 10;

--Top 10 Categories by Quantity Sold

select 
	p.product_category_name,
	count(*) as products_sold
from order_items oi
join products p
	on oi.product_id = p.product_id
group by p.product_category_name
order by products_sold desc
limit 10;

--Top Categories by Customer Satisfaction

select
	p.product_category_name,
	round(avg(r.review_score), 2) as avg_review_score
from products p
join order_items oi
	on p.product_id = oi.product_id
join orders o
 	on oi.order_id = o.order_id
join reviews r
	on o.order_id = r.order_id
group by p.product_category_name
having count(*) >= 100
order by avg_review_score desc
limit 10;

-- Lowest Rated Categories

select
	p.product_category_name,
	round(avg(r.review_score), 2) as avg_review_score
from products p
join order_items oi
	on p.product_id = oi.product_id
join orders o
 	on oi.order_id = o.order_id
join reviews r
	on o.order_id = r.order_id
group by p.product_category_name
having count(*) >= 100
order by avg_review_score asc
limit 10;