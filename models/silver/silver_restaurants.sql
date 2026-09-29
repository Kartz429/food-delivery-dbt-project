select
    restaurant_id,
    upper(restaurant_name) as restaurant_name,
    city
from {{ ref('bronze_restaurants') }}