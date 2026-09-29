# CI/CD Pipeline
**Status: not implemented yet** (no workflow files in the project).
**Planned design:** GitHub Actions on pull request → `dbt deps` → `dbt build --select state:modified+ --target dev`; on merge to main → `dbt build --target prod`.
`automation/` only syncs files and pushes to two GitHub repos; it isn't CI.
