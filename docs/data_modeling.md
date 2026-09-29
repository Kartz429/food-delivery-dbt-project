# Data Modeling
- **Grain of fact_orders:** one row per order.
- **Measures:** amount. **Attributes:** status.
- **Dimensions:** customer (SCD2, `customer_sk`), restaurant.
- **Marts:** `mart_gmv` = count and sum(amount) of delivered orders by customer city.
- **Planned:** hash surrogate keys; join fact to dimension version valid at order time (orders have no timestamp yet, which needs adding).
