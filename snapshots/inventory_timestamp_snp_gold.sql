{% snapshot inventory_gold_timestamp_snp %}

{{
    config(
        target_schema='snapshots',
        unique_key='product_id',
        strategy='timestamp',
        updated_at='data_load_utc'
    )
}}

SELECT
    product_id,
    name,
    inventory_quantity,
	eliminado_por_fivetran,
    data_load_utc
FROM {{ ref('fct_inventory') }}

{% endsnapshot %}