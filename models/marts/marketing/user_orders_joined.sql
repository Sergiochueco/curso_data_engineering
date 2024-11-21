WITH stg_users AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__users') }}
)
, stg_orders AS(
    SELECT *
    FROM {{ ref('base_sql_server_dbo__orders') }}
)
, stg_addresses AS(
    SELECT *
    FROM {{ref('stg_sql_server_dbo__addresses')}}
)
, stg_state AS(
    SELECT *
    FROM {{ref('stg_sql_server_dbo__state')}}
)
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.data_created_utc,
    u.data_updated_utc,
    u.address_id,
    a.zipcode,
    s.states_usa,
    a.country,
    o.order_id,
    a.state_id
    -- sum(case when e.event_type = 'page_view' THEN 1 ELSE 0 END) AS page_view,
    -- sum(case when e.event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS add_to_cart,
    -- sum(case when e.event_type = 'checkout' THEN 1 ELSE 0 END) AS checkout,
    -- sum(case when e.event_type = 'package_shipped' THEN 1 ELSE 0 END) AS package_shipped
FROM stg_orders as o
LEFT JOIN stg_users as u
    ON o.user_id = u.user_id
LEFT JOIN stg_addresses as a
    ON o.address_id = a.address_id
LEFT JOIN stg_state as s
    ON a.state_id = s.state_id
