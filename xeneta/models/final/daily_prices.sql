
{{ config(
  materialized='incremental',
  incremental_strategy='delete+insert',
  unique_key=['day','equipment_id','origin_location','destination_location','location_type'],
  on_schema_change='append_new_columns'
) }}

{% set BACKFILL_DAYS = 60  %}

{% set MIN_COMP = var('coverage_min_companies', 5) %}
{% set MIN_SUPP = var('coverage_min_suppliers', 2) %}

with base as (
  select
    day,
    d_id,
    origin_pid,
    destination_pid,
    equipment_id,
    company_id,
    supplier_id,
    total_charge_usd
  from {{ ref('int_datapoints_with_charges') }}
),

port_region_map as (
  select p.pid, p.region_slug, r.parent_slug
  from {{ ref('stg_ports') }} p
  left join {{ ref('stg_regions') }} r
    on p.region_slug = r.slug
),

port_lane as (
  select
    b.day,
    b.equipment_id,
    b.origin_pid::varchar as origin_location,
    b.destination_pid::varchar as destination_location,
    'port' as location_type,
    b.company_id,
    b.supplier_id,
    b.total_charge_usd
  from base b
  where b.origin_pid <> b.destination_pid
),

region_lane as (
  select
    b.day,
    b.equipment_id,
    m1.region_slug as origin_location,
    m2.region_slug as destination_location,
    'region' as location_type,
    b.company_id,
    b.supplier_id,
    b.total_charge_usd
  from base b
  join port_region_map m1 on m1.pid = b.origin_pid
  join port_region_map m2 on m2.pid = b.destination_pid
  where m1.region_slug <> m2.region_slug
),

parent_region_lane as (
  select
    b.day,
    b.equipment_id,
    coalesce(m1.parent_slug, m1.region_slug) as origin_location,
    coalesce(m2.parent_slug, m2.region_slug) as destination_location,
    'parent_region' as location_type,
    b.company_id,
    b.supplier_id,
    b.total_charge_usd
  from base b
  join port_region_map m1 on m1.pid = b.origin_pid
  join port_region_map m2 on m2.pid = b.destination_pid
  where coalesce(m1.parent_slug, m1.region_slug)
     <> coalesce(m2.parent_slug, m2.region_slug)
),

unioned as (
  select * from port_lane
  union all
  select * from region_lane
  union all
  select * from parent_region_lane
),

agg as (
  select
    day,
    equipment_id,
    origin_location,
    destination_location,
    location_type,
    count(*) as total_contracts,
    count(distinct company_id) as company_count,
    count(distinct supplier_id) as supplier_count,
    avg(total_charge_usd) as avg_price_usd,
    percentile_cont(0.5) within group (order by total_charge_usd) as median_price_usd,
    min(total_charge_usd) as min_price_usd,
    max(total_charge_usd) as max_price_usd
  from unioned
  group by day, equipment_id, origin_location, destination_location, location_type
)

select
  day,
  equipment_id,
  origin_location,
  destination_location,
  location_type,
  total_contracts,
  company_count,
  supplier_count,
  round(avg_price_usd, 2) as avg_price_usd,
  round(median_price_usd, 2) as median_price_usd,
  round(min_price_usd, 2) as min_price_usd,
  round(max_price_usd, 2) as max_price_usd,
  (company_count >= {{ MIN_COMP }} and supplier_count >= {{ MIN_SUPP }}) as dq_ok,
  current_localtimestamp() as generated_at
from agg
{% if is_incremental() %}
where day >= current_date - interval '{{ BACKFILL_DAYS }} day'
{% endif %}
