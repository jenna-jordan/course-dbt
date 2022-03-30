{% macro one_hot_encode(column_name, model_name, model_alias) %}

{%-
set possible_values = dbt_utils.get_column_values(
        table = ref(model_name), 
        column = column_name
        )
-%}

{% for val in possible_values %}
case when {{model_alias}}.{{column_name}} = '{{val}}' then 1 else 0 end as is_{{val}}
{%- if not loop.last %},{% endif -%}
{% endfor %}

{% endmacro %}