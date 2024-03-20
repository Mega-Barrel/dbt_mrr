-- Intermediate layer for daily date_spine model

WITH raw_date_spine AS (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="'2019-10-11'",
        end_date="'2023-07-01'"
    )
    }}
)

SELECT
    DATE(date_day) AS date_day
FROM
    raw_date_spine
