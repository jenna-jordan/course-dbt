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
    max(is_{{event_type}}) as has_{{event_type}}
    {%- if not loop.last %},{% endif -%}
    {% endfor %}
from int_event_types
group by session_guid