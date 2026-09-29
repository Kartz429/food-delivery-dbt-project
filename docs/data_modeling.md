# Data Modeling
- **Grain of fact_orders:** one row per order.
- **Measures:** amount. **Attributes:** status.
- **Dimensions:** customer (SCD2, hash `customer_sk`), restaurant (`restaurant_id`).
- **Marts:** `mart_gmv` = delivered orders and GMV by customer city; `mart_city_sales` = revenue by city.
- **Known trade-off:** orders carry no timestamp, so the fact joins the current customer version. Adding an order timestamp would allow point-in-time joins to the SCD2 validity window.
