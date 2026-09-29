# Implementation

| Area | What exists |
|---|---|
| Seeds | customers (4), orders (5), restaurants (3), country_codes (3) |
| Bronze | bronze_customers/orders/restaurants (views, tag `bronze`) |
| Silver | silver_customers/orders/restaurants (views, tag `silver`) |
| Gold dims | dim_customers, dim_restaurants, dim_customers_scd2 |
| Gold facts | fact_orders, fact_orders_incremental |
| Marts | mart_gmv, mart_city_sales, gold_sales |
| Snapshot | customers_snapshot (check strategy on `city`) |
| Macro | customer_type (VIP if amount > 200) |
| Demos | jinja_demo, loop_demo, macro_demo, scd_type1_demo, scd_type2_demo, country_list |
| Analyses | gmv_by_city |
| Tests | 24 schema tests + 2 singular tests (see testing_strategy.md) |
| CI | GitHub Actions workflow `dbt_ci.yml` (`dbt build` on DuckDB) |
| dbt starter models | disabled in `dbt_project.yml` |

## Design decisions
- `fact_orders` joins the **current** customer version (`dbt_valid_to is null`) to avoid duplicating orders once history exists. Orders have no timestamp, so point-in-time attribution isn't possible yet.
- `customer_sk` is a deterministic hash of `customer_id` and `dbt_valid_from`, stable across runs.

## Limitations
- Data volume is tiny (seed CSVs), so incremental and performance behaviour are illustrative.
- `fact_orders_incremental` filters on `order_id > max(order_id)`; it would miss late or updated rows.
- No `source()` definitions: seeds act as the raw layer.
- Models were validated with a SQL simulation (SQLite) of the compiled logic; the authoritative check is the CI run of `dbt build`.
