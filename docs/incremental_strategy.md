# Incremental Strategy
`fact_orders_incremental`: `materialized='incremental'`, `unique_key='order_id'`, and on incremental runs filters `order_id > max(order_id)` of the target. Works for append-only, increasing IDs. **Improvement:** use an `updated_at` watermark to catch late or changed rows; use `--full-refresh` after logic changes. The model is not yet referenced downstream.
