-- Grain: one row per order.
-- Joins the CURRENT version of each customer (dbt_valid_to is null) so orders
-- are not duplicated once a customer has history in the SCD2 dimension.
-- Point-in-time attribution needs an order timestamp, which the seed data lacks.
select
    o.order_id,
    c.customer_sk,
    r.restaurant_id,
    o.amount,
    o.status
from {{ ref('silver_orders') }} o
join {{ ref('dim_customers_scd2') }} c
    on o.customer_id = c.customer_id
   and c.dbt_valid_to is null
join {{ ref('dim_restaurants') }} r
    on o.restaurant_id = r.restaurant_id
