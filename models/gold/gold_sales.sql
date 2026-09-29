{{ config(materialized='table') }}

select
    c.customer_name,
    sum(o.amount) as total_sales
from {{ ref('silver_orders') }} o
join {{ ref('silver_customers') }} c
    on o.customer_id = c.customer_id
group by c.customer_name
