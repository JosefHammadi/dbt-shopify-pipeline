with orders as 
( select * from
{{ ref('stg_raw_shopify__orders') }}
),

customers as (
    select * from {{ ref('stg_raw_shopify__customers') }}
)


select
        -- ids
    orders.order_id,
    cast(JSON_VALUE(orders.customer_id) as int64) as customer_id,

        -- customer info
    customers.first_name,
    customers.last_name,
    customers.first_name || ' ' || customers.last_name as full_name,

        -- order details
    orders.email,
    orders.financial_status,
    orders.fulfillment_status,

        -- derived order status
        case
        when orders.financial_status = 'paid' and orders.fulfillment_status = 'fulfilled' then 'complete'
        when orders.financial_status = 'paid' and orders.fulfillment_status is null       then 'paid_not_shipped'
        when orders.financial_status = 'refunded'                                         then 'refunded'
        when orders.financial_status = 'pending'                                          then 'pending'
        else 'other'
        end as order_status_category,

        -- financials
    orders.subtotal_price,
    orders.total_price_usd,
    orders.total_discounts,
    orders.total_outstanding,
    orders.current_total_price,
    orders.current_total_tax,
    orders.taxes_included,
    orders.currency,

        -- discount flag
    case
        when orders.total_discounts > 0 then true
        else false
    end as has_discount,

    -- high value flag
    case
        when orders.total_price_usd > 100 then true
        else false
    end as is_high_value_order,

        -- marketing
    orders.buyer_accepts_marketing,

        -- timestamps
    orders.processed_at,
    orders.created_at,
    orders.updated_at

from orders
left join customers 
on cast(json_value(orders.customer_id) as int64) = customers.customer_id

