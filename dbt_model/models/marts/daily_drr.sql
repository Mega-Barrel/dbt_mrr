-- One Big Table for Daily drr view by customer and invoice level

WITH final_drr AS (
    SELECT
        *
    FROM
        {{ ref('int_revenue_daily') }}
)

SELECT
    *
FROM
    final_drr
