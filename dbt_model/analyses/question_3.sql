-- Drill down into a customer on any given day to see how the customer attributed
-- to MRR on that given day and which invoice items contributed to the MRR on the
-- given day

-- For this query,
-- Date considered is 8th March, 2022 and
-- customer_id = 80fe6c44-a72c-499e-959b-cf196e9fb3a6 AND


SELECT
    date_day,
    customer_id,
    ARRAY_AGG(
        DISTINCT invoice_id 
        ORDER BY invoice_id ASC
    ) AS invoice_items,
    ROUND(
        SUM(daily_revenue), 
        2
    ) AS daily_recurring_reveue
FROM
    {{ ref('daily_drr') }}
WHERE
    customer_id = '80fe6c44-a72c-499e-959b-cf196e9fb3a6'
AND
    date_day = '2022-03-08'
GROUP BY
  1, 2
;