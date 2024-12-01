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
    o.order_id,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.data_created_utc,
    u.data_updated_utc,
    u.address_id,
    a.zipcode,
    a.states_usa,
    a.country,
    count(o.order_id) AS total_number_orders,
    o.promo_id_TOTAL_ORDER,
    pr.discount_in_USD AS total_discount_USD,
    sum(o.shipping_cost_per_product_calculate) AS total_shipping_cost_usd,
    (p.price_USD * o.quantity) + o.shipping_cost_per_product_calculate - pr.discount_in_USD AS total_order_cost_USD,
    sum(o.quantity) AS total_quantity_products,
    sum(o.quantity) - count(o.product_id) AS total_diff_products

FROM fct_detail_orders AS o
LEFT JOIN dim__users AS u
    ON o.user_id = u.user_id
LEFT JOIN dim__addresses_users AS a
    ON o.address_id = a.address_id
LEFT JOIN dim__promos AS pr
    ON o.promo_id_TOTAL_ORDER = pr.promo_id
LEFT JOIN dim__products AS p
    ON o.product_id = p.product_id

GROUP BY 
    o.order_id,
    u.user_id, 
    u.first_name, 
    u.last_name, 
    u.email, 
    u.phone_number, 
    u.data_created_utc, 
    u.data_updated_utc, 
    u.address_id, 
    a.zipcode,
    a.states_usa,
    a.country,
    o.promo_id_TOTAL_ORDER,
    pr.discount_in_USD,
    total_order_cost_USD
ORDER BY a.states_usa ASC
