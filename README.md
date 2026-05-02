# dbt Shopify Pipeline

An end-to-end analytics engineering project built on a real Shopify store. Raw data flows from Shopify through Airbyte into BigQuery, where dbt transforms it into clean, tested, documented mart models ready for analysis.

## Stack

| Layer | Tool |
|---|---|
| Source | Shopify |
| Ingestion | Airbyte |
| Warehouse | BigQuery |
| Transformation | dbt Core |

## Project Structure
models/
├── staging/
│   ├── _sources.yml              # Source definitions and source tests
│   ├── stg_raw_shopify__customers.sql
│   ├── stg_raw_shopify__orders.sql
│   ├── stg_raw_shopify__products.sql
│   └── stg_raw_shopify__inventory_items.sql
└── marts/
├── _marts.yml                # Model documentation and tests
├── _marts.md                 # Column-level documentation blocks
├── dim_customers.sql
├── dim_products.sql
└── fct_orders.sql
tests/
├── assert_no_negative_order_amounts.sql
├── assert_no_future_orders.sql
└── assert_customers_have_email.sql

## Data Models

### Staging Layer
One model per source table. Renames columns to a consistent convention, casts data types, and references raw sources via `{{ source() }}`. No joins or business logic.

### Mart Layer

**`dim_customers`** — One row per customer. Includes contact info, marketing preferences, lifetime spend, order count, and a derived `is_active` flag from account state.

**`dim_products`** — One row per product. Includes title, vendor, product type, inventory levels, and a derived `is_active` flag from product status.

**`fct_orders`** — One row per order. Joins order data with customer names, derives `order_status_category` from financial and fulfillment status, and flags discounted and high-value orders (>$100).

## Tests

**Generic tests** (defined in `_marts.yml`):
- `unique` and `not_null` on all primary keys
- `accepted_values` on `order_status_category` and `status` fields
- `relationships` test ensuring every `customer_id` in `fct_orders` exists in `dim_customers`

**Custom singular tests** (defined in `tests/`):
- No order has a negative total amount
- No order has a future timestamp
- Every customer has a non-null email

## DAG
raw_shopify.customers ──→ stg_raw_shopify__customers ──→ dim_customers
──→ fct_orders
raw_shopify.orders ───→ stg_raw_shopify__orders ────────→ fct_orders
raw_shopify.products ──→ stg_raw_shopify__products ──→ dim_products
raw_shopify.inventory_items ──→ stg_raw_shopify__inventory_items

## Running the Project

```bash
# Install dependencies
dbt deps

# Run all models
dbt run

# Run tests
dbt test

# Run models and tests together
dbt build
```

## Key Concepts Practiced

- Dimensional modeling (Kimball methodology) — fact and dimension table separation
- Staging layer abstraction — raw sources never referenced directly in marts
- Type casting — handling JSON to INT64 type mismatches from Shopify's API
- dbt testing — generic tests, relationships tests, and custom singular tests
- dbt documentation — `doc()` blocks and column-level descriptions
- Tags and meta — models tagged by layer and domain for selective execution
- Automated daily runs — dbt Cloud job syncing with Airbyte on a 24-hour schedule
