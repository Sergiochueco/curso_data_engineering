{{
  config(
    materialized='view'
  )
}}

WITH stg_products_inventory AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__products') }}
)
SELECT 
    product_id,
    inventory_quantity,
    CASE 
        WHEN inventory_quantity < 5 THEN 'URGENT REPLENISHING' 
        WHEN inventory_quantity >= 5 AND inventory_quantity < 15 THEN 'WARNING'
        ELSE 'OK' 
        END AS alert_inventory,
	eliminado_por_fivetran,
    data_load_utc
FROM stg_products_inventory