-- Fails (returns a row) if the fact has more/fewer rows than source orders (join fan-out or loss).
select f.fact_rows, s.source_rows
from (select count(*) as fact_rows from {{ ref('fact_orders') }}) f
cross join (select count(*) as source_rows from {{ ref('silver_orders') }}) s
where f.fact_rows <> s.source_rows
