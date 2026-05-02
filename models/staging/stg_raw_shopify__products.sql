with 

source as (

    select * from {{ source('raw_shopify', 'products') }}

),

renamed as (

    select
    id AS product_id,
    title,
    vendor,
    product_type,
    status,
    tags,
    total_variants,
    total_inventory,
    is_gift_card,
    tracks_inventory,
    published_at,
    created_at,
    updated_at

    from source

)

select * from renamed
