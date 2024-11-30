{{
  config(
    materialized='table'
  )
}}

WITH addresses_users AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__addresses') }}
)
SELECT 
    SELECT 
    country,
    address_id,
    address,
    zipcode,
    state_id,
    states_usa,
    eliminado_por_fivetran,
    data_load_utc
FROM addresses_users