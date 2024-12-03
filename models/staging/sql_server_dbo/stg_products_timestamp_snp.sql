{{
  config(
    materialized='view'
  )
}}

WITH snp_products_bronze AS (
    SELECT * 
    FROM {{ ref('products_bronze_timestamp_snp') }}
)
SELECT 
    product_id,
	price AS price_USD,
	name,
	inventory AS inventory_quantity,
	_FIVETRAN_DELETED AS eliminado_por_fivetran,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_FIVETRAN_SYNCED)) AS data_load_utc
FROM snp_products_bronze