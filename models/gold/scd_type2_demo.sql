select
    1 as customer_id,
    'Mumbai' as city,
    '2024-01-01' as valid_from,
    '2025-01-01' as valid_to,
    false as is_current

union all

select
    1 as customer_id,
    'Pune' as city,
    '2025-01-02' as valid_from,
    null as valid_to,
    true as is_current