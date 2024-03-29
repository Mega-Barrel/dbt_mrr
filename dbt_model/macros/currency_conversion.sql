-- MACRO to convert currency to EURO

{% macro currency_conversion(currency, amount) %}
    ROUND(
        CASE
            WHEN {{currency}} = 'dkk' THEN {{amount}} / 7.45
            WHEN {{currency}} = 'sek' THEN {{amount}} / 11.22
            WHEN {{currency}} = 'gbp' THEN {{amount}} / 0.87
            ELSE {{amount}}
        END
        , 2
    )
{% endmacro %}