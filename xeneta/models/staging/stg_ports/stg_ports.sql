with source_ports as (
    select * from {{ source('raw_stg_ports', 'ports') }}
),

deduplicated as (
    select 
        pid,
        code,
        name,
        slug,
        country,
        country_code,
        row_number() over(partition by pid order by pid) as pid_rn,
        row_number() over(partition by code order by pid) as code_rn
    from source_ports
)
select
    pid,
    code,
    name,
    slug as region_slug,
    country,
    country_code,
    current_localtimestamp() as loaded_at
from deduplicated
where pid_rn = 1 and code_rn = 1
