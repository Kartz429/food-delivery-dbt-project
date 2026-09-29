# Project Structure
```
my_first_project/
├── dbt_project.yml
├── seeds/        customers, orders, restaurants, country_codes
├── models/
│   ├── bronze/   3 models
│   ├── silver/   3 models
│   ├── gold/     dims, facts, marts, demos, schema.yml
│   └── example/  dbt starter models
├── snapshots/    customers_snapshot.sql
├── macros/       customer_type.sql
├── tests/        (empty)
├── analyses/     (empty)
└── automation/   Python scripts that sync docs/code to the two GitHub repos
```
