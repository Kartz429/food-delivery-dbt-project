select
    city,
    count(order_id) as total_orders,
    sum(amount) as revenue
from {{ ref('fact_orders') }}
where status = 'delivered'
group by city