# CI/CD Pipeline

**CI (implemented):** `.github/workflows/dbt_ci.yml`, triggered on push to `main` and on pull requests.

```
checkout → setup Python 3.11 → pip install -r requirements.txt
   → dbt debug → dbt build (seeds, snapshot, models, tests) → dbt docs generate → upload docs artifact
```
- Uses the dedicated `ci/profiles.yml` (DuckDB file `ci.duckdb`, created fresh in the runner) via `DBT_PROFILES_DIR=ci`.
- A failing model or test fails the workflow.

**CD (not implemented):** there is no automated deployment to a production warehouse. Prod is a local DuckDB file (`prod.duckdb`).

**Next:** publish dbt docs to GitHub Pages; slim CI (`state:modified+`).
