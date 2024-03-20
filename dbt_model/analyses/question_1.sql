-- Daily recurring revenue
SELECT
  date_day,
  ROUND(SUM(daily_revenue), 2) AS daily_recurring_reveue
FROM
  {{ ref('daily_drr') }}
GROUP BY
  1
ORDER BY
  1 ASC
;


-- Weekly recurring revenue
SELECT
  DATE_TRUNC(date_day, WEEK) AS week,
  ROUND(SUM(daily_revenue), 2) AS weekly_recurring_reveue
FROM
  {{ ref('daily_drr') }}
GROUP BY
  1
ORDER BY
  1 ASC
;


-- Monthly recurring revenue
SELECT
  DATE_TRUNC(date_day, MONTH) AS month,
  ROUND(SUM(daily_revenue), 2) AS monthly_recurring_reveue
FROM
  {{ ref('daily_drr') }}
GROUP BY
  1
ORDER BY
  1 ASC
;


-- Quarterly recurring revenue
SELECT
  FORMAT_DATE('%Y-%Q', date_day) quarter,
  ROUND(SUM(daily_revenue), 2) AS quaterly_recurring_reveue
FROM
  {{ ref('daily_drr') }}
GROUP BY
  1
ORDER BY
  1 ASC
;


-- Yearly recurring revenue
SELECT
  DATE_TRUNC(date_day, YEAR) AS year,
  ROUND(SUM(daily_revenue), 2) AS yearly_recurring_reveue
FROM
  {{ ref('daily_drr') }}
GROUP BY
  1
ORDER BY
  1 ASC
;