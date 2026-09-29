# Implementation
| Area | What exists |
|---|---|
| Seeds | customers (4), orders (5), restaurants (3), country_codes (3) |
| Bronze | bronze_customers/orders/restaurants |
| Silver | silver_customers/orders/restaurants |
| Gold dims | dim_customers, dim_restaurants, dim_customers_scd2 |
| Gold facts | fact_orders, fact_orders_incremental |
| Marts | mart_gmv, mart_city_sales, gold_sales |
| Snapshot | customers_snapshot (check on city) |
| Macro | customer_type (VIP if amount > 200) |
| Demos | jinja_demo, loop_demo, macro_demo, scd_type1_demo, scd_type2_demo, country_list |
| Environments | dev.duckdb and prod.duckdb present; profiles.yml not in repo |
| CI/CD | not implemented |

## Known Limitations
- `gold_sales`, `macro_demo` reference `customer_name`, which `silver_orders` doesn't contain.
- `mart_city_sales` references `city`, which `fact_orders` doesn't contain (`mart_gmv` gets city correctly via the dimension).
- `fact_orders` joins the SCD2 dimension on `customer_id` without a validity window; `restaurant_sk` is the natural key.
- `row_number()` surrogate keys aren't stable between runs.
- No `source()` / sources.yml; minimal tests.
(Identified by code review; models were not executed for this documentation.)
Suggested replacements are in [docs/proposed_fixes/](proposed_fixes/).
