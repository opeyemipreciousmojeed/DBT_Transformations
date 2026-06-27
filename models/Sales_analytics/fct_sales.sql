--{{ config(materialized='table') }}
--I want to make this always go to Mart and not want to set it from the profile.yml file, so I will set it here in the model file.

{{ config(materialized='table', schema='MARTS') }}

with source_data as (

    select order_id,
           amount,
            current_timestamp() as load_time
        from {{ ref('stg_sales') }}   
       
)

select *
from source_data