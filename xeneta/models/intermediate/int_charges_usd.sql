with dp as (
  select
    d_id, valid_from, valid_to, company_id, supplier_id, origin_pid, destination_pid, equipment_id
  from {{ ref('stg_datapoints') }}
),

fx as (
  select day, currency, rate
  from {{ ref('stg_exchange_rates') }}
),


contract_days as (
  select
    dp.d_id,
    dp.company_id,
    dp.supplier_id,
    dp.origin_pid,
    dp.destination_pid,
    dp.equipment_id,
    fx.day
  from dp
  join (select distinct day from fx) fx
    on fx.day between dp.valid_from and dp.valid_to
),

charges as (
  select d_id, upper(trim(currency)) as currency, value
  from {{ ref('stg_charges') }}
),

charges_daily as (
  select
    cd.d_id,
    cd.day,
    c.currency,
    c.value,
    fx.rate
  from contract_days cd
  join charges c
    on c.d_id = cd.d_id
  left join fx
    on fx.currency = c.currency
   and fx.day = cd.day
)

select
  d_id,
  day,
  currency,
  value,
  case
    when currency = 'USD' then value
    when rate is not null then value / rate
    else null
  end as value_usd,
  current_localtimestamp() as transformed_at
from charges_daily
