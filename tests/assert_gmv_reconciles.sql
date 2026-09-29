-- Fails (returns a row) if total GMV in the mart differs from delivered order amounts in silver.
select m.total_gmv, s.total_delivered
from (select sum(gmv) as total_gmv from {{ ref('mart_gmv') }}) m
cross join (
    select sum(amount) as total_delivered
    from {{ ref('silver_orders') }}
    where status = 'delivered'
) s
where m.total_gmv <> s.total_delivered
