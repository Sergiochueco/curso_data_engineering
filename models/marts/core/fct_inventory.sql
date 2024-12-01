{{
  config(
    materialized='table'
  )
}}

WITH stg_products_inventory AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__products') }}
)
SELECT 
    product_id,
    name,
    inventory_quantity,
	eliminado_por_fivetran,
    data_load_utc
FROM stg_products_inventory