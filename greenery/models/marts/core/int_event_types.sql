{{
  config(
    materialized='view'
  )
}}

with stg_events as (
    select * from {{ ref( 'stg_events') }}
)

select 
    e.event_guid,
    {{ one_hot_encode('event_type', 'stg_events', 'e') }},
    e.session_guid,
    e.product_guid
from stg_events e