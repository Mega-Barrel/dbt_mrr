## dbt_mrr DAG
![dbt_fa](/assets/dbt-dag.png)

## Model Overview
For the project, I have decided to use a One Big Table (OBT) approach for faster query response by removing the need for multiple table JOIN's on the fly. The relevant data for calculating MRR is stored in one table.

-- **Staging:** This model modifies / cleans the column names for upstream consumption.

-- **Intermediate:** This layer handles all the table `JOIN's` and necessary `Transformations`. This layer is also responsible to create a *date_spine* for the timeframe specified.

-- **Mart:** This layer acts as a `One Big Table (OBT)` table used to perform analysis. 

Modeling **Monthly Recurring Revenue (MRR)** offer advantages in terms of simplicity, efficiency, flexibility, and scalability.

## Applying Tests on Models
Here are some tests to ensure MRR data is valid in terms of quality, freshness, and logic.

- Source Data Validation
  - Assuming, every customer have unique invoices, we can write a test to check for `duplicates` invoice_ids.
  - **type** column in `invoice_item table` only contains 2 values (*invoiceitem* and *subscription*), we can write `accepted_values` test to make sure **type** column does not contains any other values.

- Relationships Tests
  - Validate that all of the records in a child table have a corresponding record in a parent table for `referential integrity` check.
