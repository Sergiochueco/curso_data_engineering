SELECT *
FROM {{ ref('base_sql_server_dbo__orders') }}
WHERE data_delivered_at_utc < data_created_at_utc

