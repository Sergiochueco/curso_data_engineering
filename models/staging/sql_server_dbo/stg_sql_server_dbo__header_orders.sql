{{
  config(
    materialized='table'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ ref('base_sql_server_dbo__orders') }}
)
SELECT 
    order_id,
    data_created_at_utc,
    address_id,
    user_id,
    id_shipping_service,
	shipping_cost_euros,
    order_cost_euros,
    order_total_euros,
    promo_id,
    status
    data_estimated_delivery_at_utc,
    data_delivered_at_utc,
	tracking_id,
    eliminado_por_fivetran,
    data_load_utc
FROM src_orders

