{{
  config(
    materialized='table'
  )
}}

WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
    ),

add_no_promo AS (
    SELECT
        promo_id,
        discount,
        status,
        _fivetran_deleted,
        _fivetran_synced AS date_load
    FROM src_promos
    )

SELECT * 
FROM add_no_promo
UNION ALL 
SELECT ('sin promo',0,'sin promo',0001-01-01 00:00:00.000 +0000,0001-01-01 00:00:00.000 +0000)