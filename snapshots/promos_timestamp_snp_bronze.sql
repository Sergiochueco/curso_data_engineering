{% snapshot promos_bronze_timestamp_snp %}

{{
    config(
        target_schema='snapshots',
        unique_key='promo_id',
        strategy='timestamp',
        updated_at='_fivetran_synced'
    )
}}

SELECT
    promo_id,
    discount,
    status,
    _fivetran_deleted,
    _fivetran_synced
FROM {{ source('sql_server_dbo','promos') }}

{% endsnapshot %}


          