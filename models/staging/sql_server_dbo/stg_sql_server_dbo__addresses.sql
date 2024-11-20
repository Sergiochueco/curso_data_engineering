{{
  config(
    materialized='table'
  )
}}

WITH distinct_adress AS (
    SELECT * 
    FROM {{ ref('base_sql_server_dbo__addresses') }}
)
SELECT 
    DISTINCT
        country,
        address_id,
        address,
        state_id,
        zipcode,
        eliminado_por_fivetran,
        data_load_utc
FROM distinct_adress


