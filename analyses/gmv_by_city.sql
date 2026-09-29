-- Ad-hoc analysis: top cities by GMV (compile with `dbt compile`, run the output in your SQL client).
select city, total_orders, gmv
from {{ ref('mart_gmv') }}
order by gmv desc
