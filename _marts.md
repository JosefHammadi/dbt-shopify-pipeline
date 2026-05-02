{% docs dim_customers %}
One row per customer. Contains customer profile information from Shopify including contact details, marketing preferences, and lifetime spending metrics.
{% enddocs %}

{% docs dim_products %}
One row per product. Contains product catalogue information from Shopify including title, vendor, product type, inventory levels, and active status.
{% enddocs %}

{% docs fct_orders %}
One row per order. Contains transactional order data from Shopify enriched with customer information and derived business metrics such as order status category, discount flags, and high value order flags.
{% enddocs %}

{% docs customer_id %}
Primary key for customers. Unique identifier assigned by Shopify to each customer.
{% enddocs %}

{% docs product_id %}
Primary key for products. Unique identifier assigned by Shopify to each product.
{% enddocs %}

{% docs order_id %}
Primary key for orders. Unique identifier assigned by Shopify to each order.
{% enddocs %}
