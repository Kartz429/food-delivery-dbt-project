# Architecture
```
customers.csv ─► customers(seed) ─► bronze_customers ─► silver_customers ─┬─► dim_customers (select *)
                                                                          └─► customers_snapshot ─► dim_customers_scd2 ─┐
restaurants.csv ► restaurants ─► bronze_restaurants ─► silver_restaurants ─► dim_restaurants ───────────────────────────┤
orders.csv ─────► orders ──────► bronze_orders ──────► silver_orders ──────────────────────────────────────────────────┴─► fact_orders ─► mart_gmv
                                                        silver_orders ─► fact_orders_incremental
```
- **Bronze:** `select *` from seeds (raw as-is).
- **Silver:** column selection, `upper()` on names, `lower()` on status.
- **Gold:** dimensions, facts, marts.
Sources: no `source()` used; seeds are the raw input.
