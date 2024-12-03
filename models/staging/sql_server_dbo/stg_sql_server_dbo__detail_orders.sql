{{
  config(
    materialized='incremental',
    unique_key=['order_id','product_id'],
    on_schema_change ='fail'
  )
}}


WITH base_orders AS (
    SELECT * 
    FROM {{ ref('base_sql_server_dbo__orders') }}
)
, base_order_items AS (
    SELECT *
    FROM {{ref('base_sql_server_dbo__order_items') }}
)
SELECT 
    o.order_id,
    oi.product_id,
    oi.quantity,
    o.data_created_at_utc,
    DATE(o.data_created_at_utc) AS date,
    TIME(o.data_created_at_utc) AS time_date,
    o.address_id,
    o.user_id,
    o.id_shipping_service,
	o.shipping_cost_USD AS shipping_cost_USD_TOTAL_ORDER,
    o.shipping_cost_USD / COUNT(oi.product_id) OVER (PARTITION BY o.order_id) AS shipping_cost_per_product_calculate,
    o.promo_id AS promo_id_TOTAL_ORDER,
    o.status,
    o.data_estimated_delivery_at_utc,
    o.data_delivered_at_utc,
	o.tracking_id,
    o.eliminado_por_fivetran,
    o.data_load_utc
FROM base_orders AS o
JOIN base_order_items AS oi 
    ON o.order_id = oi.order_id
ORDER BY ORDER_ID


{% if is_incremental() %}

  where data_load_utc > (select max(data_load_utc) from {{ this }})

{% endif %}