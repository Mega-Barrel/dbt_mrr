-- Get raw_invoice_item data

WITH raw_invoice_item AS (
    SELECT
        *
    FROM
        {{ source('public', 'invoice_item') }}
)

SELECT
    type AS invoice_item_type,
    period_end,
    period_start,
    amount AS invoice_item_amount,
    currency,
    _synced AS last_synced_time,
    invoice_id,
    id
FROM
    raw_invoice_item
