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
    select *,
        case when order_status = 'delivered' then 0 else 1 end as order_in_progress
    from {{ ref( 'stg_orders') }}
),

stg_order_items as (
    select * from {{ ref( 'stg_order_items') }}
),

int_products_bought as(
    select * from {{ ref( 'int_products_bought') }}
),

orders_made as (
    select 
        o.user_guid, 
        count(o.order_guid) as total_orders,
        sum(p.products_bought_count) as total_products,
        sum(p.items_bought_count) as total_items,
        sum(order_total) as total_spent,
        max(order_in_progress) as order_in_progress
    from stg_orders o
        left join int_products_bought p on o.order_guid = p.order_guid
    group by user_guid
)

select 
    u.user_guid,
    u.email,
    u.phone_number,
    a.address_guid,
    a.street_address,
    a.zipcode,
    a.state,
    a.country,
    coalesce(o.total_orders, 0) as order_count,
    coalesce(o.total_products, 0) as total_products,
    coalesce(o.total_items, 0) as total_items,
    coalesce(o.total_spent, 0) as total_spent,
    coalesce(o.order_in_progress, 0) as order_in_progress
from stg_users u
    left join stg_addresses a on u.address_guid = a.address_guid
    left join orders_made o on u.user_guid = o.user_guid