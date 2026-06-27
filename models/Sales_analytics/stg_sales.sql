{{ config(materialized='table') }}

with source_data as (

    select replace(order_id, 'AB', '10') as order_id,
           customer_id,
           order_date,
           amount,
            current_timestamp() as load_time
        from {{ source('raw', 'sales') }}   
        where order_Id is not null

)

select *
from source_data
qualify row_number() over (partition by order_id order by load_time desc) = 1