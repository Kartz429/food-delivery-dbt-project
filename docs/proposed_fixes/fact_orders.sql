-- Joins only the CURRENT customer version to avoid duplicating orders once history exists.
-- Trade-off: orders have no timestamp, so point-in-time attribution isn't possible yet.
select
    o.order_id,
    c.customer_sk,
    r.restaurant_id as restaurant_id,
    o.amount,
    o.status
from {{ ref('silver_orders') }} o
join {{ ref('dim_customers_scd2') }} c
    on o.customer_id = c.customer_id
   and c.dbt_valid_to is null
join {{ ref('dim_restaurants') }} r
    on o.restaurant_id = r.restaurant_id
