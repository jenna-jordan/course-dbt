{{
  config(
    materialized='view'
  )
}}

with stg_orders as (
    select * from {{ ref( 'stg_orders') }}
),

stg_order_items as (
    select * from {{ ref( 'stg_order_items') }}
),

stg_addresses as (
    select * from {{ ref( 'stg_addresses') }}
),

int_products_bought as (
    select * from {{ ref( 'int_products_bought') }}
)

select 
    o.order_guid,
    o.user_guid,
    o.address_guid,
    a.zipcode,
    a.state,
    a.country,
    o.created_at_utc,
    o.order_cost,
    p.products_bought_count,
    p.items_bought_count,
    o.shipping_cost,
    o.order_total,
    o.tracking_guid,
    o.shipping_service,
    o.estimated_delivery_at_utc,
    o.delivered_at_utc,
    delivered_at_utc - estimated_delivery_at_utc as delivery_estimate_error,
    delivered_at_utc - created_at_utc as delivery_time,
    o.order_status
from stg_orders o
    left join int_products_bought p on o.order_guid = p.order_guid
    left join stg_addresses a on o.address_guid = a.address_guid