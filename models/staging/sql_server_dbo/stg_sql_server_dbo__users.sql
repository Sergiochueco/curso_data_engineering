{{
  config(
    materialized='table'
  )
}}

WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}
)
SELECT 
    user_id,
    address_id,
    last_name,
    first_name,
    phone_number,
    email,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(updated_at)) AS data_updated_utc,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(created_at)) AS data_created_utc,
    _FIVETRAN_DELETED AS eliminado_por_fivetran,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_FIVETRAN_SYNCED)) AS data_load_utc
FROM src_users