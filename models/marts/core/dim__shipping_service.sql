{{
  config(
    materialized='table'
  )
}}

WITH stg_shipping_service AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__shipping_service') }}
)
SELECT
    id_shipping_service,
	shipping_service,
    eliminado_por_fivetran,
    data_load_utc
FROM stg_shipping_service

