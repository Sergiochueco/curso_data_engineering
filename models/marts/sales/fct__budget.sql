{{
  config(
    materialized='table'
  )
}}

WITH stg_budget AS (
    SELECT * 
    FROM {{ ref('stg_google_sheets__budget') }}
)
SELECT 
    _row,
   product_id,
   quantity,
   month,
   year,
   data_load_utc
FROM stg_budget