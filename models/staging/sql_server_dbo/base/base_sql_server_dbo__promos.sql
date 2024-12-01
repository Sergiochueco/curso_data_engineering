{{
  config(
    materialized='view'
  )
}}

WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
), insert_new_value AS (
     SELECT 
        'sin promo' AS promo_id, 
        0 AS discount,  
        'active' AS status, 
        null AS _fivetran_deleted,
        '0001-01-01 00:00:00.000 +0200'::TIMESTAMP_TZ AS _fivetran_synced
), union_values AS (
    SELECT * 
    FROM src_promos
    UNION ALL 
    SELECT *
    FROM insert_new_value
)

SELECT *
FROM union_values



          