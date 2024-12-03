{{
  config(
    materialized='table'
  )
}}

WITH int_inventory AS (
    SELECT * 
    FROM {{ ref('int__inventory') }}
)
SELECT 
    product_id,
    inventory_quantity,
    alert_inventory,
	eliminado_por_fivetran,
    data_load_utc
FROM int_inventory