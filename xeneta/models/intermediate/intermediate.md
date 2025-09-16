## int_charges_usd

{% docs doc__int_overview %}
Business logic at daily grain:
- expand each contract to every day in its validity window.
- convert charge lines to USD using the FX rate for that day.
{% enddocs %}

{% docs doc__int_day %}
Expanded contract day between valid_from and valid_to for days present in FX.
{% enddocs %}

{% docs doc__int_currency %}
Original charge currency.
{% enddocs %}

{% docs doc__int_value %}
Original charge amount.
{% enddocs %}

{% docs doc__int_value_usd %}
Charge amount converted to USD using that day’s FX.
{% enddocs %}

{% docs doc__int_transformed_at %}
Model transform timestamp.
{% enddocs %}

## int_datapoints_with_charges

{% docs doc__int_total_charge_usd %}
Sum of USD-converted charge line items for a given (d_id, day) after daily expansion and FX application.
{% enddocs %}

{% docs doc__int_charges_total %}
Total charge lines for (d_id, day).
{% enddocs %}

{% docs doc__int_charges_converted %}
Charge lines with non-NULL USD for (d_id, day).
{% enddocs %}
