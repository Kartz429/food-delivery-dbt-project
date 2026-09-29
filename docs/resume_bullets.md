# Resume Bullets (all backed by code in this project)
- Built a layered dbt project (Bronze–Silver–Gold) on DuckDB covering food-delivery customers, restaurants and orders.
- Implemented SCD Type 2 customer history using a dbt snapshot (check strategy) and a surrogate-keyed dimension.
- Designed a star schema with an orders fact and customer/restaurant dimensions, plus a city-level GMV mart.
- Built an incremental orders model with `unique_key` to avoid full reloads.
- Created a reusable Jinja macro and applied Jinja loops/variables in models.
- Built a data-quality suite of 26 dbt tests (unique, not_null, relationships, accepted_values, and reconciliation tests for GMV and fact grain).
- Wrote Python automation to sync documentation to two GitHub repositories.

*Add after your first green run in the Actions tab:* Set up GitHub Actions CI that runs `dbt build` (seeds, snapshot, models, tests) on every push and pull request.

*Not yet implemented:* `source()` definitions, automated production deployment.
