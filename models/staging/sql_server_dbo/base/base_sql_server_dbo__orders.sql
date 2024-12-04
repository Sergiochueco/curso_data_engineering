{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
)
, clean_values_promos AS (
    
SELECT 
    order_id,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(created_at)) AS data_created_at_utc,
    address_id,
    user_id,
    {{ dbt_utils.generate_surrogate_key(['shipping_service']) }} AS id_shipping_service,
	shipping_service,
	shipping_cost AS shipping_cost_USD,
    order_cost AS order_cost_USD,
    order_total AS order_total_USD,
    lower(CASE WHEN promo_id = '' THEN 'sin promo' ELSE promo_id END) AS description_promo,
    promo_id,
    status,
	-- promo_id as description_promo,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(estimated_delivery_at)) AS data_estimated_delivery_at_utc,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(delivered_at)) AS data_delivered_at_utc,
	tracking_id,
    _FIVETRAN_DELETED AS eliminado_por_fivetran,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_FIVETRAN_SYNCED)) AS data_load_utc
FROM src_orders
)
SELECT 
    order_id,
    data_created_at_utc,
    address_id,
    user_id,
    id_shipping_service,
	shipping_service,
	shipping_cost_USD,
    order_cost_USD,
    order_total_USD,
    {{ dbt_utils.generate_surrogate_key(['description_promo'])}} AS promo_id,
    status,
    data_estimated_delivery_at_utc,
    data_delivered_at_utc,
	tracking_id,
    eliminado_por_fivetran,
    data_load_utc
FROM clean_values_promos


