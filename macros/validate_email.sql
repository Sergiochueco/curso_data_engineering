{% macro validate_email(email) %}
    regexp_like({{ email }}, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$')
{% endmacro %}

{% test email_format(model, column_name) %}
    select {{ column_name }}
    from {{ model }}
    where not {{ validate_email(column_name) }}
{% endtest %}