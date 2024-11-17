{{
  config(
    materialized='table'
  )
}}

WITH src_budget AS (
    SELECT * 
    FROM {{ source('google_sheets', 'budget') }}
)
SELECT 
   product_id,
   quantity,
   MONTH(month) AS month,
   YEAR(month) AS year,
   CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_FIVETRAN_SYNCED)) AS data_load_utc
FROM src_budget
ORDER BY product_id