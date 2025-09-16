with source_regions as (
    select * from {{ source('raw_stg_regions', 'regions') }}
)
select
    slug,
    name,
    parent as parent_slug,
    current_localtimestamp() as loaded_at
from source_regions
