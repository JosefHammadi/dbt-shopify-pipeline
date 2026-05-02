with 

source as (

    select * from {{ source('raw_shopify', 'inventory_items') }}

),

renamed as (

SELECT
    id AS inventory_item_id,
    sku,
    cost,
    tracked,
    currency_code,
    requires_shipping,
    created_at,
    updated_at

    from source

)

select * from renamed
