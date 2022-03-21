{{
  config(
    materialized='table'
  )
}}

with addresses as (
    select * from {{ source('postgres', 'addresses') }}
)

SELECT 
    address_id as address_guid,
    address as street_address,
    zipcode::varchar(5),
    state,
    country
FROM addresses