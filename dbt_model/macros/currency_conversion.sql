-- MACRO to convert currency to EURO

{% macro to_euro(currency, invoice_item_amount) %}
    ROUND(
        CASE
            WHEN currency = 'dkk' THEN invoice_item_amount / 7.45
            WHEN currency = 'sek' THEN invoice_item_amount / 11.22
            WHEN currency = 'gbp' THEN invoice_item_amount / 0.87
            ELSE invoice_item_amount
        END
        , 2
    )
{% endmacro %}