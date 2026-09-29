# Deployment Strategy
**Present:** `dev.duckdb` and `prod.duckdb` database files exist, indicating separate dev/prod databases. `profiles.yml` isn't in the repository, so target configuration isn't documented here.
**Planned:** add `profiles.yml.example`; run `dbt build --target prod` only from CI on the main branch.
