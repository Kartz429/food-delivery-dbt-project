{% snapshot customers_snapshot %}

{{
    config(
        unique_key='customer_id',
        strategy='check',
        check_cols=['city']
    )
}}

select *
from {{ ref('silver_customers') }}

{% endsnapshot %}