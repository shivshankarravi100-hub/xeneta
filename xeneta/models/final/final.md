{% docs doc__final_overview %}
Daily aggregated shipping lane prices and metrics at three different granularities (port, region, parent_region).
{% enddocs %}

{% docs doc__final_day %}
The date for which prices are aggregated.
{% enddocs %}

{% docs doc__final_equipment_id %}
Its an integer between 1 and 6 inclusive, identifies the type of the container (also known as equipment) that is used for transportation.
{% enddocs %}

{% docs doc__final_origin_location %}
Starting point of the shipping lane. Can be a port code, region slug, or parent region slug depending on the location_type.
{% enddocs %}

{% docs doc__final_destination_location %}
End point of the shipping lane. Can be a port code, region slug, or parent region slug depending on the location_type.
{% enddocs %}

{% docs doc__final_location_type %}
Indicates the granularity of the price aggregation:
- 'port': Direct port-to-port routes
- 'region': Regional level aggregation
- 'parent_region': Top-level regional aggregation
{% enddocs %}

{% docs doc__final_total_contracts %}
Total number of valid shipping contracts included.
{% enddocs %}

{% docs doc__final_company_count %}
Number of distinct companies (buyers) providing data.
{% enddocs %}

{% docs doc__final_supplier_count %}
Number of distinct suppliers (shipping service providers).
{% enddocs %}

{% docs doc__final_avg_price_usd %}
Mean price in USD for all valid contracts.
{% enddocs %}

{% docs doc__final_median_price_usd %}
Median price in USD.
{% enddocs %}

{% docs doc__final_min_price_usd %}
Lowest valid contract price in USD.
{% enddocs %}

{% docs doc__final_max_price_usd %}
Highest valid contract price in USD.
{% enddocs %}

{% docs doc__final_dq_ok %}
Data quality flag indicating sufficient market coverage.
{% enddocs %}

{% docs doc__final_generated_at %}
Timestamp when this data was generated.
Used for tracking data freshness and versioning.
{% enddocs %}
