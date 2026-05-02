with source as (

    select * from {{ source('raw_shopify', 'orders') }}

),

renamed as (

SELECT
    id AS order_id,
    customer AS customer_id,
    email,
    financial_status,
    fulfillment_status,
    subtotal_price,
    total_price_usd,
    total_discounts,
    total_outstanding,
    current_total_price,
    current_total_tax,
    taxes_included,
    currency,
    presentment_currency,
    buyer_accepts_marketing,
    created_at,
    updated_at,
    processed_at

    from source

)

select * from renamed
