with source_charges as (
  select * from {{ source('raw_stg_charges', 'charges_1') }}
  union all
  select * from {{ source('raw_stg_charges', 'charges_2') }}
  union all
  select * from {{ source('raw_stg_charges', 'charges_3') }}
)


select
    d_id,
    currency,
    cast(charge_value as float) as value,
    current_localtimestamp() as loaded_at
from source_charges
where
    d_id is not null
    and currency is not null
    and value is not null
