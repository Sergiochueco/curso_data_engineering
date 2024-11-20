{{
  config(
    materialized='table'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
)
SELECT 
    order_id,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(created_at)) AS data_created_at_utc,
    address_id,
    user_id,
	shipping_service,
	shipping_cost AS shipping_cost_euros,
    order_cost AS order_cost_euros,
    order_total AS order_total_euros,
    {{ dbt_utils.generate_surrogate_key(['promo_id']) }} AS promo_id,
    status,
	-- promo_id as description_promo,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(estimated_delivery_at)) AS data_estimated_delivery_at_utc,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(delivered_at)) AS data_delivered_at_utc,
	tracking_id,
    _FIVETRAN_DELETED AS eliminado_por_fivetran,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_FIVETRAN_SYNCED)) AS data_load_utc
FROM src_orders

