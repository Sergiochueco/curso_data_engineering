{{
  config(
    materialized='table'
  )
}}

WITH base_products AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__products') }}
)
SELECT 
    product_id,
    name,
	price_USD,
	eliminado_por_fivetran,
    data_load_utc
FROM base_products