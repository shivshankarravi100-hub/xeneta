with source_rates as (
    select * from {{ source('raw_stg_exchange_rates', 'exchange_rates') }}
),
typed as (
    select
        cast(day as date) as day,
        upper(trim(currency)) as currency,
        cast(rate as double) as rate
    from source_rates
)
select
    day, currency,
    case when rate <= 0 then null else rate end as rate,
    current_localtimestamp() as loaded_at
from typed
where rate is not null
