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
    select * from {{ ref('int_event_types') }}
),

fact_sessions as (
    select * from {{ ref('fact_sessions') }}
),

stg_products as (
    select * from {{ ref('stg_products') }}
),

product_session as (
    select distinct 
        session_guid, 
        product_guid
    from int_event_types
    where product_guid is not null
)

select 
  s.session_guid, 
  {% for event_type in event_types %}
    {{event_type}}_count,
  {% endfor %}
  ps.product_guid,
  p.product_name,
  p.price
from fact_sessions s
join product_session ps on s.session_guid = ps.session_guid
join stg_products p on ps.product_guid = p.product_guid
