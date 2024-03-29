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


**Note:** Please head over to dbt_model/README.md file for project overview 😀