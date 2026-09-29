# Changelog

## [0.2.0] - 2026-09-29
### Added
- GitHub Actions CI (`dbt build` + docs artifact) and `ci/profiles.yml`
- Silver-layer tests, relationships and accepted_values tests, and two singular tests
- Model and column descriptions for `dbt docs`
- `analyses/gmv_by_city.sql`, `scripts/generate_charts.py` and README charts
### Updated
- `dbt_project.yml`: layer defaults and tags, starter models disabled
- `requirements.txt` with version ranges
### Improved
- `dim_customers_scd2`: deterministic hash surrogate key instead of `row_number()`
- `fact_orders`: joins the current customer version, so no fan-out with SCD2 history
### Fixed
- `gold_sales`, `macro_demo`: referenced a column missing from `silver_orders`
- `mart_city_sales`: referenced `city` missing from `fact_orders`
- `loop_demo`: generated invalid SQL (`union all` without `select`)

## [0.1.0] - 2026-09-29
### Added
- Bronze/Silver/Gold models, seeds, snapshot, SCD2 dimension, incremental fact, GMV mart, macro, initial docs
