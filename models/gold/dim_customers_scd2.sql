-- Deterministic surrogate key: stable across runs, unique per customer version.
select
    md5(cast(customer_id as varchar) || '-' || cast(dbt_valid_from as varchar)) as customer_sk,
    customer_id,
    customer_name,
    city,
    dbt_valid_from,
    dbt_valid_to
from {{ ref('customers_snapshot') }}
