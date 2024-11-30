{{
  config(
    materialized='view'
  )
}}

WITH distinct_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
)
SELECT 
    DISTINCT
        country,
        address_id,
        address,
        zipcode ::VARCHAR(15) AS zipcode,
        {{ dbt_utils.generate_surrogate_key(['state']) }} AS state_id,
        state as states_usa,
        _FIVETRAN_DELETED AS eliminado_por_fivetran,
        CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_FIVETRAN_SYNCED)) AS data_load_utc
FROM distinct_addresses