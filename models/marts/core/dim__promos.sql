{{
  config(
    materialized='table'
  )
}}

WITH stg_promos AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__promos') }}
)
SELECT 
    promo_id,
    description,
    discount_in_USD,
    status,
    eliminado_por_fivetran,
    data_load_utc
FROM stg_promos