with source_datapoints as (
  select * from {{ source('raw_stg_datapoints', 'datapoints_1') }}
  union all
  select * from {{ source('raw_stg_datapoints', 'datapoints_2') }}
  union all
  select * from {{ source('raw_stg_datapoints', 'datapoints_3') }}
)

select
    d_id,
    cast(created as timestamp) as created_at,
    cast(valid_from as date) as valid_from,
    cast(valid_to as date) as valid_to,
    origin_pid,
    destination_pid,
    company_id,
    supplier_id,
    equipment_id,
    current_localtimestamp() as loaded_at
from source_datapoints
where
    d_id is not null
    and valid_from is not null
    and valid_to is not null
    and valid_from <= valid_to
    and equipment_id between 1 and 6
