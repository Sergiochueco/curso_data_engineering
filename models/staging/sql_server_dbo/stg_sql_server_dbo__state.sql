{{
  config(
    materialized='table'
  )
}}

WITH distinct_state AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
)
SELECT 
    DISTINCT
        SHA2(state, 256) AS state_id,
        state as state_usa,
        _FIVETRAN_DELETED AS eliminado_por_fivetran,
        CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_FIVETRAN_SYNCED)) AS data_load_utc
FROM distinct_state


