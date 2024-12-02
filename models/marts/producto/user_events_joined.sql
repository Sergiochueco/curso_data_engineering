{{
  config(
    materialized='table'
  )
}}

WITH dim_users AS (
    SELECT * 
    FROM {{ ref('dim__users') }}
)
, fct_events AS(
    SELECT *
    FROM {{ ref('stg_sql_server_dbo__events') }}
)
SELECT 
    e.session_id,
    u.user_id,
    u.first_name,
    u.email,
    MIN(data_created_at_utc) AS first_event_time_utc,
    MAX(data_created_at_utc) AS last_event_time_utc,
    DATEDIFF('minute',MIN(data_created_at_utc),MAX(data_created_at_utc)) AS session_length_minutes,
    sum(case when e.event_type = 'page_view' THEN 1 ELSE 0 END) AS page_view,
    sum(case when e.event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS add_to_cart,
    sum(case when e.event_type = 'checkout' THEN 1 ELSE 0 END) AS checkout,
    sum(case when e.event_type = 'package_shipped' THEN 1 ELSE 0 END) AS package_shipped
FROM fct_events as e
LEFT JOIN dim_users as u
    ON e.user_id = u.user_id
GROUP BY e.session_id,u.user_id,u.first_name,u.email

