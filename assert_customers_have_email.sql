select customer_id
from {{ ref('dim_customers') }}
where email is null
or email = ''
