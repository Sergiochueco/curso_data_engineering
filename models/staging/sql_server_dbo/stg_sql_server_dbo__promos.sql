{{
  config(
    materialized='table'
  )
}}

WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
), insert_new_value AS (
     SELECT 
        'sin promo' AS promo_id, 
        0 AS discount,  
        'sin promo' AS status, 
        null AS _fivetran_deleted,
        '0001-01-01 00:00:00.000 +0200'::TIMESTAMP_TZ AS _fivetran_synced
), union_values AS (
    SELECT * 
    FROM src_promos
    UNION ALL 
    SELECT *
    FROM insert_new_value
)
SELECT 
    SHA2(promo_id, 256) AS hashed_promo_id,
    LOWER(PROMO_ID) AS description,
    DISCOUNT AS discount_in_dollars,
    STATUS AS status,
    _FIVETRAN_DELETED AS eliminado_por_fivetran,
    _FIVETRAN_SYNCED AS data_load_at_madrid_utc
FROM union_values