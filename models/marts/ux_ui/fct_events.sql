{{
  config(
    materialized='table'
  )
}}

WITH stg_events AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__events') }}
)
SELECT 
    event_id,
	page_url,
	event_type,
	user_id,
	product_id,
	session_id,
    data_created_at_utc,
	order_id,
	eliminado_por_fivetran,
    data_load_utc
FROM stg_events