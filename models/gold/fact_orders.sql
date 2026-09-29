select
    o.order_id,
    c.customer_sk,
    r.restaurant_id as restaurant_sk,
    o.amount,
    o.status

from {{ ref('silver_orders') }} o

join {{ ref('dim_customers_scd2') }} c
    on o.customer_id = c.customer_id

join {{ ref('dim_restaurants') }} r
    on o.restaurant_id = r.restaurant_id
