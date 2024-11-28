{{
  config(
    materialized='view'
  )
}}

WITH src_events AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'events') }}
)
SELECT 
    event_id,
	page_url,
	event_type,
	user_id,
	product_id,
	session_id,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(created_at)) AS data_created_at_utc,
	order_id,
	_FIVETRAN_DELETED AS eliminado_por_fivetran,
    CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_FIVETRAN_SYNCED)) AS data_load_utc
FROM src_events