{{
  config(
    materialized='view'
  )
}}

with stg_order_items as (
    select * from {{ ref( 'stg_order_items') }}
)

select 
    order_guid, 
    count(product_guid) as products_bought_count,
    sum(quantity) as items_bought_count
from stg_order_items
group by order_guid