# 🍔 Food Delivery Analytics — dbt Project

[![dbt CI](https://github.com/Kartz429/food-delivery-dbt-project/actions/workflows/dbt_ci.yml/badge.svg)](https://github.com/Kartz429/food-delivery-dbt-project/actions/workflows/dbt_ci.yml)
![dbt](https://img.shields.io/badge/dbt-Core-FF694B?logo=dbt&logoColor=white)
![DuckDB](https://img.shields.io/badge/DuckDB-warehouse-FFF000?logo=duckdb&logoColor=black)
![Tests](https://img.shields.io/badge/dbt%20tests-26-2da44e)
![License](https://img.shields.io/badge/license-MIT-green)

An analytics-engineering project that models food-delivery data (customers, restaurants, orders) with **dbt** on **DuckDB**: layered Bronze → Silver → Gold models, an **SCD Type 2** customer dimension built from a snapshot, an **incremental** orders model, a **GMV mart** for dashboards, **26 data tests**, and **GitHub Actions CI**.

## Results (sample data)

<p>
  <img src="docs/assets/gmv_by_city.svg" alt="GMV by city" width="49%">
  <img src="docs/assets/orders_by_status.svg" alt="Orders by status" width="49%">
</p>

*Charts come from the seed data via `scripts/generate_charts.py`.*

## Architecture

```mermaid
flowchart LR
  subgraph Seeds
    c[customers]:::seed
    o[orders]:::seed
    r[restaurants]:::seed
  end
  c --> bc[bronze_customers]:::bronze --> sc[silver_customers]:::silver
  o --> bo[bronze_orders]:::bronze --> so[silver_orders]:::silver
  r --> br[bronze_restaurants]:::bronze --> sr[silver_restaurants]:::silver
  sc --> snap[customers_snapshot]:::snap --> dc[dim_customers_scd2]:::gold
  sr --> dr[dim_restaurants]:::gold
  so --> f[fact_orders]:::gold
  dc --> f
  dr --> f
  f --> gmv[mart_gmv]:::mart
  dc --> gmv
  f --> city[mart_city_sales]:::mart
  dc --> city
  so --> inc[fact_orders_incremental]:::gold
  classDef seed fill:#eeeeee,stroke:#999,color:#111;
  classDef bronze fill:#f3d9b1,stroke:#b07d2b,color:#111;
  classDef silver fill:#dfe6ee,stroke:#7a8b9c,color:#111;
  classDef snap fill:#e9d8fd,stroke:#8b5cf6,color:#111;
  classDef gold fill:#fff2a8,stroke:#c9a400,color:#111;
  classDef mart fill:#b7e4c7,stroke:#2d8a4e,color:#111;
```

## Data Model (star schema)

```mermaid
erDiagram
  dim_customers_scd2 ||--o{ fact_orders : customer_sk
  dim_restaurants ||--o{ fact_orders : restaurant_id
```

`fact_orders` grain: one row per order. `mart_gmv` aggregates delivered orders by customer city.

## What's Implemented

| Area | Details |
|---|---|
| Seeds | customers, orders, restaurants, country_codes |
| Bronze / Silver | 3 + 3 models (raw pass-through → cleaned) |
| Gold | dimensions, `fact_orders`, `fact_orders_incremental`, marts |
| Snapshot + SCD2 | `customers_snapshot` (check on `city`) → `dim_customers_scd2` with hash `customer_sk` |
| Macro | `customer_type` (VIP / NORMAL) |
| Tests | 24 schema tests (unique, not_null, relationships, accepted_values) + 2 singular reconciliation tests |
| CI | GitHub Actions: `dbt build` + docs artifact on every push / PR |
| Environments | dev / prod / ci DuckDB targets |

## Quickstart

```bash
pip install -r requirements.txt
cp profiles.yml.example ~/.dbt/profiles.yml   # or: export DBT_PROFILES_DIR=ci
dbt build                                     # seeds + snapshot + models + tests
dbt docs generate && dbt docs serve           # lineage graph
python scripts/generate_charts.py --db dev.duckdb
```

## Repository Structure

```
├── models/          bronze/ silver/ gold/  (+ schema.yml with tests and descriptions)
├── seeds/           source CSVs
├── snapshots/       customers_snapshot.sql
├── macros/          customer_type.sql
├── tests/           singular tests
├── analyses/        gmv_by_city.sql
├── scripts/         chart generator
├── ci/              CI profile
├── .github/workflows/dbt_ci.yml
├── docs/            architecture, strategies, changelog, resume bullets
└── dbt_project.yml
```

## Documentation
Index in [docs/README.md](docs/README.md): [architecture](docs/architecture.md) · [data modeling](docs/data_modeling.md) · [snapshot strategy](docs/snapshot_strategy.md) · [incremental strategy](docs/incremental_strategy.md) · [testing strategy](docs/testing_strategy.md) · [CI/CD](docs/ci_cd_pipeline.md) · [changelog](docs/changelog.md)

## Roadmap
- [ ] `source()` definitions and freshness checks
- [ ] Order timestamps → point-in-time joins to the SCD2 dimension
- [ ] Timestamp-based incremental logic
- [ ] Publish dbt docs to GitHub Pages
- [ ] Slim CI (`state:modified+`)

## Related
Learning notes: [dbt-learning-journey](https://github.com/Kartz429/dbt-learning-journey)

## License
MIT — see [LICENSE](LICENSE).
