{{
  config(
    materialized='view'
  )
}}

with stg_users as (
    select * from {{ ref( 'stg_users') }}
),

stg_addresses as (
    select * from {{ ref( 'stg_addresses') }}
),

stg_orders as (
    select * from {{ ref( 'stg_orders') }}
),

orders_made as (
    select user_guid, count(order_guid) as order_count
    from stg_orders
    group by user_guid
)

select 
    u.user_guid,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.created_at_utc,
    u.updated_at_utc,
    a.address_guid,
    a.street_address,
    a.zipcode,
    a.state,
    a.country,
    coalesce(o.order_count, 0) as order_count
from stg_users u
    left join stg_addresses a on u.address_guid = a.address_guid
    left join orders_made o on u.user_guid = o.user_guid