select
    c.city,
    count(f.order_id) as total_orders,
    sum(f.amount) as gmv
from {{ ref('fact_orders') }} f
join {{ ref('dim_customers_scd2') }} c
    on f.customer_sk = c.customer_sk
where f.status = 'delivered'
group by c.city