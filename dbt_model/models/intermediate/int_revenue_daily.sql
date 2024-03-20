-- Intermediate Layer
-- Perform Currency Transformations and Generate DRR (Daily Reccuring Revenue)

-- Perform EURO Conversion and Date Difference between end and start date
WITH currency_conversion AS (
    SELECT
        invoice_item_type,
        period_end,
        period_start,
        invoice_item_amount,
        currency,
        {{ to_euro('currency', 'invoice_item_amount') }} AS amount_euro,
        invoice_id,
        id
    FROM
        {{ ref('stg_invoice_item') }}
),

-- Get days between period_end and period_start, 
-- where invoice_item_type = 'subscription'
subscription_period AS (
    SELECT
        period_end,
        period_start,
        DATE_DIFF(
            DATE(period_end), DATE(period_start),
            DAY
        ) AS days_diff,
        invoice_id,
        id,
        amount_euro
    FROM
        currency_conversion
    WHERE
        invoice_item_type = 'subscription'
),

-- Calculate DRR (Daily Recurring Revenue)
-- JOIN stg_invoice ON subscription_period.invoice_id = stg_invoice.id
-- sub_period refers to subscription_period CTE
raw_daily_drr AS (
    SELECT
        sub_period.invoice_id,
        invoice.customer_id,
        sub_period.amount_euro,
        sub_period.period_end,
        sub_period.period_start,
        sub_period.days_diff,
        ROUND(
            COALESCE(
                sub_period.amount_euro / NULLIF(
                    sub_period.days_diff, 
                    0
                )
            ), 2
        ) AS daily_revenue
    FROM
        subscription_period sub_period
    JOIN
        {{ ref('stg_invoice') }} invoice
    ON
        sub_period.invoice_id = invoice.invoice_id
),

-- Generate Daily drr data JOIN 
-- JOIN daily_drr with int_date_spin model
-- ON start date is before the date we want in our table
    -- AND end date is after the date we want in out model, or there is no end date

daily_spinned_revenue AS (
    SELECT
        date_spine.date_day,
        raw_daily_drr.invoice_id,
        raw_daily_drr.customer_id,
        raw_daily_drr.daily_revenue
    FROM
        raw_daily_drr
    LEFT JOIN
        {{ ref('int_date_spine') }} date_spine
    ON
        -- start date is before the date we want in our table
        DATE(raw_daily_drr.period_start) <= date_spine.date_day
    -- end date is after the date we want in out model, or there is no end date
    AND (
        DATE(raw_daily_drr.period_end) > date_spine.date_day
        OR DATE(raw_daily_drr.period_end) is null
    )
)

SELECT
    *
FROM
    daily_spinned_revenue
WHERE
    date_day IS NOT NULL

