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

products_bought as(
    select order_guid, count(product_guid) as products_bought
    from stg_order_items
    group by order_guid
),

items_bought as(
    select order_guid, sum(quantity) as items_bought
    from stg_order_items
    group by order_guid
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
    p.products_bought,
    i.items_bought,
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
    left join products_bought p on o.order_guid = p.order_guid
    left join items_bought i on o.order_guid = i.order_guid
    left join stg_addresses a on o.address_guid = a.address_guid