SELECT 
    product_id,
    name,
    price,
    inventory
FROM {{ source('raw', 'products') }}