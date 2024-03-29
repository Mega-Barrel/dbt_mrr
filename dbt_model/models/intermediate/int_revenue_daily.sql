-- Intermediate Layer
-- Perform Currency Transformations and Generate DRR (Daily Reccuring Revenue)

-- Perform EURO Conversion and Date Difference between end and start date
WITH raw_currency_conversion AS (
    SELECT
        invoice_item_type,
        period_end,
        period_start,
        invoice_item_amount,
        currency,
        {{ currency_conversion('currency', 'invoice_item_amount') }} AS amount_euro,
        invoice_id,
        id
    FROM
        {{ ref('stg_invoice_item') }}
),

-- Get Invoices data
invoices AS (
    SELECT
        invoice_id,
        customer_id
    FROM
        {{ ref('stg_invoice') }}
),

-- Get date_spine data
raw_date_spine AS (
    SELECT
        date_day
    FROM
        {{ ref('int_date_spine') }}
),

-- Get days diff between subscription_period
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
        raw_currency_conversion
    WHERE
        invoice_item_type = 'subscription'
),

-- Calculate DRR (Daily Recurring Revenue)
-- JOIN invoices model
-- sub_period refers to subscription_period CTE
raw_daily_drr AS (
    SELECT
        subscription_period.invoice_id,
        invoices.customer_id,
        subscription_period.amount_euro,
        subscription_period.period_end,
        subscription_period.period_start,
        subscription_period.days_diff,
        ROUND(
            COALESCE(
                subscription_period.amount_euro / NULLIF(
                    subscription_period.days_diff, 
                    0
                )
            ), 2
        ) AS daily_revenue
    FROM
        subscription_period
    JOIN
        invoices
    ON
        subscription_period.invoice_id = invoices.invoice_id
),

-- Generate Daily drr data JOIN 
-- JOIN daily_drr with raw_date_spine model
-- ON start date is before the date we want in our table
    -- AND end date is after the date we want in out model, or there is no end date
daily_spinned_drr AS (
    SELECT
        raw_date_spine.date_day,
        raw_daily_drr.invoice_id,
        raw_daily_drr.customer_id,
        IFNULL(raw_daily_drr.daily_revenue, 0.0) AS daily_revenue
    FROM
        raw_daily_drr
    LEFT JOIN
        raw_date_spine
    ON
        -- start date is before the date we want in our table
        DATE(raw_daily_drr.period_start) <= raw_date_spine.date_day
    -- end date is after the date we want in out model, or there is no end date
    AND (
        DATE(raw_daily_drr.period_end) >= raw_date_spine.date_day
        OR DATE(raw_daily_drr.period_end) is null
    )
)

SELECT
    *
FROM
    daily_spinned_drr
