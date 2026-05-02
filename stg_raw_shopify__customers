with source as (

    select * from {{ source('raw_shopify', 'customers') }}

),

renamed as (

  SELECT
    id AS customer_id,
    email,
    first_name,
    last_name,
    phone,
    state,
    currency,
    total_spent,
    orders_count,
    verified_email,
    accepts_marketing,
    created_at,
    updated_at

    from source

)

select * from renamed
