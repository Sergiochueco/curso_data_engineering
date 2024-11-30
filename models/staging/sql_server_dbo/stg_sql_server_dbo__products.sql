{{
  config(
    materialized='view'
  )
}}

WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'products') }}
)
SELECT 
    product_id,
	price AS price_USD,
	name,
	inventory AS inventory_quantity,
	_FIVETRAN_DELETED AS eliminado_por_fivetran,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_FIVETRAN_SYNCED)) AS data_load_utc
FROM src_products