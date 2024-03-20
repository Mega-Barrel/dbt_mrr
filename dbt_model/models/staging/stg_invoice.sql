-- Staging layer for Invoice table

WITH raw_invoice AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            ORDER BY
                1
        ) AS rn
    FROM
        {{ source('public', 'invoice') }}
)

-- Cleaned invoice table
SELECT
    string_field_0 AS invoice_id,
    string_field_1 AS customer_id
FROM
    raw_invoice
WHERE
    rn > 2

