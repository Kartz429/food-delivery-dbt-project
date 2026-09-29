select
    c.customer_name,
    o.amount,
    {{ customer_type('o.amount') }} as customer_category
from {{ ref('silver_orders') }} o
join {{ ref('silver_customers') }} c
    on o.customer_id = c.customer_id
