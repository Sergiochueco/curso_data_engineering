{{
  config(
    materialized='table'
  )
}}

WITH stg_detail_orders AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__detail_orders') }}

)
SELECT 
    order_id,
    product_id,
    quantity,
    data_created_at_utc,
    address_id,
    user_id,
    id_shipping_service,
	shipping_cost_USD_TOTAL_ORDER,
    shipping_cost_per_product_calculate,
    promo_id_TOTAL_ORDER,
    status,
    data_estimated_delivery_at_utc,
    data_delivered_at_utc,
	tracking_id,
    eliminado_por_fivetran,
    data_load_utc
FROM stg_detail_orders


