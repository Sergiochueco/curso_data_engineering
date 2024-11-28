{{
  config(
    materialized='view'
  )
}}

WITH base_products AS (
    SELECT * 
    FROM {{ ref('base_sql_server_dbo__products') }}
)
SELECT 
    product_id,
    name,
	price_euros,
	eliminado_por_fivetran,
    data_load_utc
FROM base_products