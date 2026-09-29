# Testing Strategy

**Schema tests (24)**
- `unique` / `not_null` on primary keys in silver, dimensions, `fact_orders`, `mart_gmv`
- `relationships`: silver orders → customers/restaurants; `fact_orders` → `dim_customers_scd2`, `dim_restaurants`
- `accepted_values` on `fact_orders.status` (`delivered`, `cancelled`)

**Singular tests (2)** in `tests/`
- `assert_gmv_reconciles`: total mart GMV equals delivered order amounts in silver
- `assert_fact_orders_grain`: fact row count equals source orders (catches join fan-out)

**Run:** `dbt test` (or `dbt build`, which also runs tests in DAG order). CI runs `dbt build` on every push and pull request.

**Next:** `source()` freshness checks, and tests for the incremental model's late-arriving data.
