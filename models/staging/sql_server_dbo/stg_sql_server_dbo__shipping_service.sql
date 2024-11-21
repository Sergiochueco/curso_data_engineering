{{
  config(
    materialized='table'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ ref('base_sql_server_dbo__orders') }}
)
SELECT 
    DISTINCT
    id_shipping_service,
	shipping_service,
    eliminado_por_fivetran,
    data_load_utc
FROM src_orders

