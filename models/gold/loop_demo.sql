{% set countries = ['India','USA','UK'] %}

select
{% for country in countries %}
    '{{ country }}' as country
{% if not loop.last %} union all {% endif %}
{% endfor %}