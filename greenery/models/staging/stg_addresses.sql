SELECT 
    address_id,
    address,
    zipcode::varchar(5),
    state,
    country
FROM {{ source('raw', 'addresses') }}