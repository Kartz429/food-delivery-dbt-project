{% set countries = ['India','USA','UK'] %}

{% for country in countries %}
select '{{ country }}' as country
{% if not loop.last %} union all {% endif %}
{% endfor %}
