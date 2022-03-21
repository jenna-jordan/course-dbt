{{
  config(
    materialized='table'
  )
}}

with order_items as (
    select * from {{ source('postgres', 'order_items') }}
)

SELECT 
    order_id as order_guid,
    product_id as product_guid,
    quantity
FROM order_items