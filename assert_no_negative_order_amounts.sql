select order_id
from {{ ref('fct_orders') }}
where total_price_usd < 0
