## Part 1 Deliverables
GitHub Repository link - https://github.com/Mega-Barrel/dbt_mrr

## Part 2 Deliverables
For the project, I have decided to use a One Big Table (OBT) approach for faster query response by removing the need for multiple table JOIN's on the fly. The relevant data for calculating MRR is stored in one table.

-- **Staging:** This model modifies / cleans the column names for upstream consumption.

-- **Intermediate:** This layer handles all the table `JOIN's` and necessary `Transformations`. This layer is also responsible to create a *date_spine* for the timeframe specified.

-- **Mart:** This layer acts as a `One Big Table (OBT)` table used to perform analysis. 

Modeling **Monthly Recurring Revenue (MRR)** offer advantages in terms of simplicity, efficiency, flexibility, and scalability.

## Part 3 Deliverables
Here are some tests to ensure MRR data is valid in terms of quality, freshness, and logic.

- Source Data Validation
  - Implement Tests to important columns such as (customer_id, amount, period_start, period_end) to check for `null values`. If null values are present, data maybe inconsistent.
  - Assuming, every customer have unique subscriptions / invoices, we can write a test to check for `duplicates` active subscription.
  - Assumning, **type** column in `invoice_item table` only contains 2 values (*invoiceitem* and *subscription*), we can write `accepted_values` test to make sure **type** column does not contains any other values.

- Freshness Tests
  - We can make use of `source_freshness` test to ensure source tables are updated regularly.
  - Schedule dbt models to run at `regular intervals` to guarantee the MRR data reflects the latest information in the table.

- Data Mart Tests
  - We can implement a test to check for `negative` revenue values.

- Relationships Tests
  - Validate that all of the records in a child table have a corresponding record in a parent table for `referential integrity` check.

**For the Staging layer, I have implemented 3 tests (stg__models.yml)**