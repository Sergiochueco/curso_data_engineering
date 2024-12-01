{% snapshot promos_silver_timestamp_snp %}

{{
    config(
        target_schema='snapshots',
        unique_key='promo_id',
        strategy='timestamp',
        updated_at='data_load_utc'
    )
}}

SELECT
    promo_id,
    description,
    discount_in_USD,
    status,
    eliminado_por_fivetran,
    data_load_utc
FROM {{ ref('stg_sql_server_dbo__promos') }}

{% endsnapshot %}