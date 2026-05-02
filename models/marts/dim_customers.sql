with customers as (
    select * from {{ ref('stg_raw_shopify__customers') }}
)

select
    -- ids
    customer_id,

    -- name
    first_name,
    last_name,
    CONCAT(first_name, ' ',last_name) as full_name,

    -- contact
    email,
    phone,
    verified_email,

    -- status
    state,
    case
        when state = 'disabled' then false
        else true
    end as is_active,

    -- marketing
    accepts_marketing,

    -- financials
    total_spent,
    orders_count,
    currency,

    -- timestamps
    created_at,
    updated_at

from customers
