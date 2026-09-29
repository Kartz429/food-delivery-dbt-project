# DAG Explanation
```
customers ► bronze_customers ► silver_customers ► customers_snapshot ► dim_customers_scd2 ─┐
                                        └► dim_customers                                  ├► fact_orders ► mart_gmv
restaurants ► bronze_restaurants ► silver_restaurants ► dim_restaurants ──────────────────┤       └► mart_city_sales
orders ► bronze_orders ► silver_orders ───────────────────────────────────────────────────┘
silver_orders ► fact_orders_incremental | gold_sales | macro_demo
```
Every arrow is a `ref()`. `dim_customers_scd2` also feeds `mart_gmv` directly. Generate the interactive graph with `dbt docs generate && dbt docs serve`.
