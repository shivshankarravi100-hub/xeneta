with conv as (
  select * from {{ ref('int_charges_usd') }}
),

agg as (
  select
    d_id,
    day,
    count(*) as charges_total,
    count(value_usd) as charges_converted,
    sum(value_usd) as total_charge_usd
  from conv
  group by 1,2
),

dp as (
  select
    d_id, created_at, valid_from, valid_to, origin_pid, destination_pid,
    company_id, supplier_id, equipment_id
  from {{ ref('stg_datapoints') }}
),

daily as (
  select
    dp.d_id,
    a.day,
    dp.created_at,
    dp.valid_from, dp.valid_to,
    dp.origin_pid, dp.destination_pid,
    dp.company_id, dp.supplier_id,
    dp.equipment_id,
    a.total_charge_usd,
    a.charges_total,
    a.charges_converted
  from dp
  join agg a using (d_id)
  where
    dp.valid_from <= dp.valid_to
    and dp.origin_pid != dp.destination_pid
    and dp.equipment_id between 1 and 6
)

select
  *,
  current_localtimestamp() as transformed_at
from daily
where charges_total = charges_converted
  and total_charge_usd > 0
