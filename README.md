


# Welcome to the Xeneta Analysis Project

This dbt project transforms raw ocean shipping contract data into a clean, reliable, and easy-to-use analytical model.

---

## Project Structure

The project is organized into three main layers, transforming the data from its raw state to a clean, aggregated final model.

* **Staging**: Models in this layer perform basic cleaning, casting, and renaming of the raw source data.

* **Intermediate**: This layer contains the core business logic, such as calculating the total price for each contract and converting it to USD for each day it is valid.

* **Final**: The final `daily_prices` model aggregates all the daily contract prices by transportation lane and adds the `dq_ok` data quality flag.

## Project map

```
xeneta-dbt/
├─ seeds/
│  └─ raw_files/
│     ├─ DE_casestudy_regions.csv
│     ├─ DE_casestudy_ports.csv
│     ├─ DE_casestudy_exchange_rates.csv
│     ├─ DE_casestudy_datapoints_1.csv
│     ├─ DE_casestudy_datapoints_2.csv
│     ├─ DE_casestudy_datapoints_3.csv
│     ├─ DE_casestudy_charges_1.csv
│     ├─ DE_casestudy_charges_2.csv
│     └─ DE_casestudy_charges_3.csv
├─ models/
│  ├─ staging/
│  │  ├─ raw_datapoints/stg_datapoints.sql
│  │  ├─ raw_charges/stg_charges.sql
│  │  ├─ stg_ports.sql
│  │  ├─ stg_regions.sql
│  │  └─ stg_exchange_rates.sql
│  ├─ intermediate/
│  │  ├─ int_charges_usd.sql
│  │  └─ int_datapoints_with_charges.sql
│  └─ final/
│     └─ daily_prices.sql
└─ README.md
```

## Data Lineage

<img width="2207" height="853" alt="image" src="https://github.com/user-attachments/assets/3ec6a47a-036e-4d2f-951b-ef69d2ac959f" />
