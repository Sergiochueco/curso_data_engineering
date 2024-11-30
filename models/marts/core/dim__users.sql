{{
  config(
    materialized='table'
  )
}}

WITH stg_users AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__users') }}
)

SELECT 
    user_id,
    address_id,
    last_name,
    first_name,
    phone_number,
    email,
    data_updated_utc,
    data_created_utc,
    eliminado_por_fivetran,
    data_load_utc
FROM stg_users