select
    customer_name,
    amount,
    {{ customer_type('amount') }} as customer_category
from {{ ref('silver_orders') }}