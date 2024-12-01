{{
  config(
    materialized='view'
  )
}}

WITH stg_promos AS (
    SELECT * 
    FROM {{ ref('base_sql_server_dbo__promos') }}
)
SELECT 
     {{ dbt_utils.generate_surrogate_key(['promo_id']) }} AS promo_id,
    LOWER(PROMO_ID) AS description,
    DISCOUNT AS discount_in_USD,
    STATUS AS status,
    _FIVETRAN_DELETED AS eliminado_por_fivetran,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_FIVETRAN_SYNCED)) AS data_load_utc
FROM stg_promos