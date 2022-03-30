{{
  config(
    materialized='view'
  )
}}

{%
set event_types = dbt_utils.get_column_values(
        table = ref('stg_events'), 
        column = 'event_type')
%}

with int_event_types as (
    select * from {{ ref( 'int_event_types') }}
)

select 
    session_guid,
    {% for event_type in event_types %}
    sum(is_{{event_type}}) as {{event_type}}_count,
    {% endfor %}
    count(distinct product_guid) as distinct_products
from int_event_types
group by session_guid