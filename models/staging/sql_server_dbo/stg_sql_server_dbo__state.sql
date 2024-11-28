{{
  config(
    materialized='view'
  )
}}

WITH distinct_state AS (
    SELECT * 
    FROM {{ ref('base_sql_server_dbo__addresses') }}
)
SELECT 
    DISTINCT
        state_id,
        states_usa,
        eliminado_por_fivetran,
        data_load_utc
FROM distinct_state


