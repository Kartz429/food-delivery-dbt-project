{% macro customer_type(amount_column) %}

case
    when {{ amount_column }} > 200 then 'VIP'
    else 'NORMAL'
end

{% endmacro %}