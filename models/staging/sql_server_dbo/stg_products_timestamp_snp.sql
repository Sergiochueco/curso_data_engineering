{{
  config(
    materialized='view'
  )
}}

WITH snp_products_bronze AS (
    SELECT * 
    FROM {{ ref('products_bronze_timestamp_snp') }}
)
SELECT 
    product_id
    , name
    , price
    , inventory
    , _fivetran_deleted
    , _fivetran_synced
FROM snp_products_bronze