{{
  config(
    materialized='table'
  )
}}

with events as (
    select * from {{ source('postgres', 'events') }}
)

SELECT 
    event_id as event_guid,
    session_id as session_guid,
    user_id as user_guid,
    event_type,
    page_url,
    created_at as created_at_utc,
    order_id as order_guid,
    product_id as product_guid
FROM events