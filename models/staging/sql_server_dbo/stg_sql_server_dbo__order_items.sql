{{
  config(
    materialized='view'
  )
}}

WITH src_order_items AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'order_items') }}
)
SELECT 
    order_id,
	product_id,
	quantity,
	_FIVETRAN_DELETED AS eliminado_por_fivetran,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_FIVETRAN_SYNCED)) AS data_load_utc
FROM src_order_items