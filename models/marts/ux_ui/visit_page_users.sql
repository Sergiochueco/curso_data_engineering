{{
  config(
    materialized='table'
  )
}}

WITH dim__users AS (
    SELECT * 
    FROM {{ ref('dim__users') }}
)
, dim__addresses_users AS(
    SELECT *
    FROM {{ ref('dim__addresses_users') }}
)
, fct_events AS(
    SELECT *
    FROM {{ ref('fct_events') }}
)
, card_shipped AS (
SELECT 
      u.user_id
    , a.zipcode
    , a.states_usa
    , e.session_id
    , SUM(CASE WHEN 
                e.event_type = 'add_to_cart' or 
                e.event_type = 'package_shipped' or 
                e.event_type = 'page_view' THEN 1 ELSE 0 END) AS total_clicks
    , SUM(CASE WHEN e.event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS number_add_cart
    , SUM(CASE WHEN e.event_type = 'package_shipped' THEN 1 ELSE 0 END) AS number_package_shipped

FROM dim__users AS u
LEFT JOIN dim__addresses_users AS a
    ON u.address_id = a.address_id
LEFT JOIN fct_events AS e
    ON u.user_id = e.user_id

GROUP BY 
      u.user_id 
    , a.zipcode
    , a.states_usa
    , e.session_id
)

SELECT 
      user_id
    , zipcode
    , states_usa
    , session_id
    , total_clicks
    , number_add_cart
    , total_clicks - number_add_cart AS diff_click_add_cart
    , number_package_shipped
    , CASE WHEN number_package_shipped = 0 THEN 'False' ELSE 'True' END AS IS_PURCHASE
FROM card_shipped