# Star Schema
```
dim_customers_scd2 (customer_sk) ─┐
                                  ├─ fact_orders (order_id, customer_sk, restaurant_sk, amount, status)
dim_restaurants (restaurant_id) ──┘
```
`mart_gmv` aggregates the star by city for dashboards.
