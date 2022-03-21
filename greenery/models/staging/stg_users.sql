{{
  config(
    materialized='table'
  )
}}

with users as (
    select * from {{ source('postgres', 'users') }}
)

SELECT 
    user_id as user_guid,
    first_name,
    last_name,
    email,
    phone_number,
    created_at as created_at_utc,
    updated_at as updated_at_utc,
    address_id as address_guid
FROM users