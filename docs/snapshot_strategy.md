# Snapshot Strategy
`customers_snapshot` uses `strategy='check'`, `check_cols=['city']`, `unique_key='customer_id'` over `silver_customers`. dbt adds `dbt_valid_from` / `dbt_valid_to`, which `dim_customers_scd2` exposes with a `customer_sk`. Run `dbt snapshot` on a schedule so changes are captured.
