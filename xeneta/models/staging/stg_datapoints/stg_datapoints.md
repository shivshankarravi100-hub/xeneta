{% docs doc__stg_datapoints_overview %}
Metadata for an ocean shipping contract between a company who wants to ship cargo in containers, and a service supplier who owns and manages the container boxes and shipping vessels.
{% enddocs %}

{% docs doc__stg_dp_d_id %}
A unique ID for a datapoint (identifies a shipping contract)
{% enddocs %}

{% docs doc__stg_dp_created_at %}
Original created/ingest timestamp from the source.
{% enddocs %}

{% docs doc__stg_dp_valid_from %}
Contract validity start date.
{% enddocs %}

{% docs doc__stg_dp_valid_to %}
Contract validity end date.
{% enddocs %}

{% docs doc__stg_dp_origin_pid %}
Origin port id.
{% enddocs %}

{% docs doc__stg_dp_destination_pid %}
Destination port id.
{% enddocs %}

{% docs doc__stg_dp_company_id %}
 Its an integer ID for the company that wants to move cargo as of this contract (the "buyer" of this shipping contract)
{% enddocs %}

{% docs doc__stg_dp_supplier_id %}
Its an integer ID for the vessel operator company that provides the shipping service (the "seller" of this contract)
{% enddocs %}

{% docs doc__stg_dp_equipment_id %}
Its an integer between 1 and 6 inclusive, identifies the type of the container (also known as equipment) that is used for transportation.
{% enddocs %}

{% docs doc__stg_dp_loaded_at %}
Timestamp when the staging model executed.
{% enddocs %}
