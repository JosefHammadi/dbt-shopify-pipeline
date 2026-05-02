

with products AS
(SELECT * FROM {{ ref('stg_raw_shopify__products') }})



select
    -- ids
    products.product_id,

    -- product info
    title,
    vendor,
    product_type,
    tags,

    -- status
    status,
    case
        when status = 'ACTIVE' then true
        else false
    end as is_active,

    -- inventory
    total_variants,
    total_inventory,
    tracks_inventory,
    is_gift_card,

    -- timestamps
    published_at,
    created_at,
    updated_at

from products 
