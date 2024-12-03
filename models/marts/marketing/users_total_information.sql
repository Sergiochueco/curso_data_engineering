{{
  config(
    materialized='table'
  )
}}

WITH dim__users AS (
    SELECT * 
    FROM {{ ref('dim__users') }}
)
, fct_detail_orders AS(
    SELECT *
    FROM {{ ref('fct__details_orders') }}
)
, dim__addresses_users AS(
    SELECT *
    FROM {{ref('dim__addresses_users')}}
)
, dim__promos AS(
    SELECT *
    FROM {{ref('dim__promos')}}
)
, dim__products AS(
    SELECT *
    FROM {{ref('dim__products')}}
)
SELECT 
      u.user_id
    , u.first_name
    , u.last_name
    , u.email
    , u.phone_number
    , u.data_created_utc
    , u.data_updated_utc
    , u.address_id
    , a.zipcode
    , a.states_usa
    , a.country
    , count(DISTINCT o.order_id) AS total_number_orders
    , sum((p.price_USD * o.quantity) + o.shipping_cost_per_product_calculate - pr.discount_in_USD) AS total_order_cost_USD
    , sum(o.shipping_cost_per_product_calculate) AS total_shipping_cost_usd
    , sum(pr.discount_in_USD) AS total_discount_USD
    , sum(o.quantity) AS total_quantity_products
    , count(DISTINCT o.product_id) AS total_diff_products

FROM dim__users AS u
LEFT JOIN dim__addresses_users AS a
    ON u.address_id = a.address_id
LEFT JOIN fct_detail_orders AS o
    ON u.user_id = o.user_id
LEFT JOIN dim__promos AS pr
    ON o.promo_id_TOTAL_ORDER = pr.promo_id
LEFT JOIN dim__products AS p
    ON o.product_id = p.product_id

GROUP BY 
      u.user_id 
    , u.first_name 
    , u.last_name 
    , u.email
    , u.phone_number 
    , u.data_created_utc 
    , u.data_updated_utc 
    , u.address_id 
    , a.zipcode
    , a.states_usa
    , a.country
   
ORDER BY u.first_name, u.last_name ASC



