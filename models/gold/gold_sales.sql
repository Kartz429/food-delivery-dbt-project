{{ config(materialized='table') }}

select
    customer_name,
    sum(amount) as total_sales
from {{ ref('silver_orders') }}
group by customer_name