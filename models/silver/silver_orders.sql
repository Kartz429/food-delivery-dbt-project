select
    order_id,
    customer_id,
    restaurant_id,
    amount,
    lower(status) as status
from {{ ref('bronze_orders') }}
