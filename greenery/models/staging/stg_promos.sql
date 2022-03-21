{{
  config(
    materialized='table'
  )
}}

with promos as (
    select * from {{ source('postgres', 'promos') }}
)

SELECT 
    promo_id,
    discount as discount_percent,
    status
FROM promos