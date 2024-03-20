-- Get company wise MRR

-- Assumption: 
    -- Company level data is available in invoice table.
    -- Every customer_id is mapped with company_name / company_id

    -- When performing JOIN operation in `raw_daily_drr` CTE,
        -- we can add company column.

        -- Example
        -- invoice.company_name
    
    -- Same can be added to `daily_spinned_revenue` CTE
        -- Example
        -- raw_daily_drr.company_name

-- Since we don't have company level data / information

-- Sample Mart view
-- Columns: 
    -- date_day, company_name, 
    -- invoice_id, customer_id, daily_revenue

-- Query to get Monthly company wise MRR

{# SELECT
    DATE_TRUNC(date_day, MONTH) AS month,
    company_name,
    ROUND(SUM(daily_revenue), 2) AS monthly_recurring_reveue
FROM
    {{ ref('daily_drr') }}
GROUP BY
    1, 2
ORDER BY
    1 ASC,
    2 ASC
; #}

-- Sample output
-- Data for 2019-11-01 Month

-- +------------------------------------------------------+
-- | month      | company_name | monthly_recurring_reveue |
-- +------------------------------------------------------+
-- | 2019-11-01 | Pleo.io      | 3579.25                  |
-- | 2019-11-01 | LYST         | 1579.78                  |
-- | 2019-11-01 | THREAD       | 849.78                   |
-- | 2019-11-01 | syft         | 1821.88                  |
-- | 2019-11-01 | drover       | 2087.01                  |
-- +------------------------------------------------------+
