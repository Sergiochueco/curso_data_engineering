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
        _FIVETRAN_SYNCED AS data_load_at_madrid_utc
FROM distinct_state


WITH distinct_adress AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
)
SELECT 
    DISTINCT
        country,
        address_id,
        address,
        SHA2(state, 256) AS state_id,
        zipcode ::VARCHAR(15) AS zipcode,
        _FIVETRAN_DELETED AS eliminado_por_fivetran,
        _FIVETRAN_SYNCED AS data_load_at_madrid_utc
FROM distinct_adress