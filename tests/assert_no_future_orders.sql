select order_id
from {{ ref('fct_orders') }}
where created_at > current_timestamp()
