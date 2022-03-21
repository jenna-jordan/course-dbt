{{
  config(
    materialized='view'
  )
}}

with stg_events as (
    select * from {{ ref( 'stg_events') }}
),

stg_products as (
    select * from {{ ref( 'stg_products') }}
)

select 
    e.event_guid,
    e.session_guid,
    e.user_guid,
    e.page_url,
    e.created_at_utc,
    e.product_guid,
    p.product_name,
    p.price,
    p.inventory_count
from stg_events e 
    left join stg_products p on e.product_guid = p.product_guid
where event_type = 'page_view'