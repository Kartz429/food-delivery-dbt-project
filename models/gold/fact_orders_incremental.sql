{{
    config(
        materialized='incremental',
        unique_key='order_id'
    )
}}

select *
from {{ ref('silver_orders') }}

{% if is_incremental() %}

where order_id >
(
    select max(order_id)
    from {{ this }}
)

{% endif %}