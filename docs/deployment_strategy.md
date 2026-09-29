# Deployment Strategy

| Environment | Where | How |
|---|---|---|
| dev | `dev.duckdb` (local) | `dbt build` |
| prod | `prod.duckdb` (local) | `dbt build --target prod` |
| ci | ephemeral `ci.duckdb` | GitHub Actions, `DBT_PROFILES_DIR=ci` |

`profiles.yml.example` shows the dev/prod targets (the real `profiles.yml` lives in `~/.dbt/` and isn't committed).
