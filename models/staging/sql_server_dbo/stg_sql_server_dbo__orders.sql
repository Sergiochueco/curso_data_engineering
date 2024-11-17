{{
  config(
    materialized='table'
  )
}}

WITH distinct_state AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
)
SELECT 
    order_id,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(created_at)) AS data_created_at_utc,
    address_id,
    user_id,
	CASE WHEN shipping_service = '' and status = 'preparing' THEN 'en preparacion' ELSE shipping_service END AS shipping_service,
	shipping_cost AS shipping_cost_dollars,
    order_cost AS order_cost_dollars,
    order_total AS order_total_dollars,
    SHA2(promo_id, 256) AS hashed_promo_id,
    status,
	-- promo_id as description_promo,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(estimated_delivery_at)) AS data_estimated_delivery_at_utc,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(delivered_at)) AS data_delivered_at_utc,
	tracking_id,
    _FIVETRAN_DELETED AS eliminado_por_fivetran,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_FIVETRAN_SYNCED)) AS data_load_utc
FROM distinct_state
