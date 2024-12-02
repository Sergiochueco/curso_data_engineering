{{
  config(
    materialized='view'
  )
}}

WITH snp_promos_bronze AS (
    SELECT * 
    FROM {{ ref('promos_bronze_timestamp_snp') }}
)
SELECT 
    promo_id,
    discount,
    status,
    _fivetran_deleted,
    _fivetran_synced
FROM snp_promos_bronze