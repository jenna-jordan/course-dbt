{{
  config(
    materialized='table'
  )
}}

with products as (
    select * from {{ source('postgres', 'products') }}
)

SELECT 
    product_id as product_guid,
    name as product_name,
    price,
    inventory as inventory_count
FROM products