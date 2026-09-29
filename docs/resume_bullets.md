# Resume Bullets (all backed by code in this project)
- Built a layered dbt project (Bronze–Silver–Gold) on DuckDB covering food-delivery customers, restaurants and orders.
- Implemented SCD Type 2 customer history using a dbt snapshot (check strategy) and a surrogate-keyed dimension.
- Designed a star schema with an orders fact and customer/restaurant dimensions, plus a city-level GMV mart.
- Built an incremental orders model with `unique_key` to avoid full reloads.
- Created a reusable Jinja macro and applied Jinja loops/variables in models.
- Added dbt generic tests (unique, not_null) on the orders fact.
- Wrote Python automation to sync documentation to two GitHub repositories.

*Add after implementing:* CI pipeline with GitHub Actions; source definitions; expanded test coverage.
