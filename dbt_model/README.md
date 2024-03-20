Welcome to dbt Monthly Recurring Revenue (MRR) project!

## Project Setup
Follow the steps to modify / create new dbt-project profile in **profiles.yml** file
- Change the **location** to your choice (Eg: EU, asia-south1, etc.)
- Change the credential file **keyfile** path (if using service account setup)
- Modify the Schema name to your own project. Best practice is to name the schema in your dev target dbt_**username**.
    - For me, schema name is **dbt_sjoshi**


## Running the DBT Models
Try running the following commands:
- dbt deps ( to install packages )
- dbt debug ( to validate your warehouse connection )
- dbt test ( to run tests on models )
- dbt run ( to execute the dbt models )

## Part 1 Deliverables
GitHub Repository link - 

## Part 2 Deliverables
For the project, I have decided to use a One Big Table (OBT) approach for faster query response by removing the need for JOIN's on the fly.


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