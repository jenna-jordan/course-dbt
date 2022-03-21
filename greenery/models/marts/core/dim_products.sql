{{
  config(
    materialized='view'
  )
}}

with stg_products as (
    select * from {{ ref( 'stg_products') }}
),

stg_order_items as (
    select * from {{ ref( 'stg_order_items') }}
),

products_bought as(
    select product_guid, sum(quantity) as total_sold
    from stg_order_items
    group by product_guid
)

select 
    p.product_guid,
    p.product_name,
    p.price,
    p.inventory_count,
    b.total_sold
from stg_products p 
    left join products_bought b on p.product_guid = b.product_guid