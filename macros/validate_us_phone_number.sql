{% macro validate_phone_number(column_name) %}
    length(trim({{ column_name }})) = 12 and
    regexp_like(trim({{ column_name }}), '^\d{3}-\d{3}-\d{4}$')
{% endmacro %}



{% test phone_number_format(model, column_name) %}
    select {{ column_name }}
    from {{ model }}
    where not {{ validate_phone_number(column_name) }}
{% endtest %}








