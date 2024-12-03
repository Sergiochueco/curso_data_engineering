{{
  config(
    materialized='table'
  )
}}

WITH fct__details_orders AS (
    SELECT *
    FROM {{ ref('fct__details_orders') }}
)
, fct__budget AS(
    SELECT *
    FROM {{ref('fct__budget')}}
)
, dim__products AS(
    SELECT *
    FROM {{ref('dim__products')}}
)
, sales_per_month AS (
SELECT 
      od.product_id
    , MONTH(od.data_created_at_utc) AS month
    , YEAR(od.data_created_at_utc) AS year
    , SUM(od.quantity) AS quantity_sales
    

FROM fct__details_orders AS od
GROUP BY od.product_id, month, year
)
SELECT 
      p.name
    , s.product_id
    , s.month
    , s.year
    , quantity_sales
    , b.quantity AS quantity_budget
    , quantity_sales - b.quantity AS diff_sales_to_budget
FROM sales_per_month AS s
JOIN fct__budget AS b
    ON s.product_id = b.product_id
JOIN dim__products AS p
    ON s.product_id = p.product_id