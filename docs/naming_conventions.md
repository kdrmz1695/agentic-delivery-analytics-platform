# Naming Conventions

## Overview

This document describes the naming conventions used across the Agentic Delivery Analytics Platform.

The conventions are designed to improve:

- readability
- consistency
- maintainability
- analytical querying
- AI-driven schema understanding

---

# General Rules

- All object names use `snake_case`
- All names use lowercase letters
- English naming is used across all layers
- Descriptive naming is preferred over abbreviations
- SQL reserved keywords are avoided

---

# Layer Naming Conventions

## Bronze Layer

Bronze tables store raw ingested source data.

### Pattern

`<schema>.<raw_table_name>`

### Example

`bronze.raw_delivery_data`

---

## Silver Layer

Silver tables contain cleaned and transformed analytical datasets.

### Pattern

`<schema>.<cleaned_table_name>`

### Example

`silver.delivery_cleaned`

---

## Gold Layer

Gold tables follow dimensional modeling conventions.

### Fact Tables

`fact_<entity>`

### Dimension Tables

`dim_<entity>`

### Examples

- `fact_deliveries`
- `dim_vehicle`
- `dim_weather`
- `dim_traffic`
- `dim_date`
- `dim_area`
- `dim_category`
- `dim_agent`

---

# Column Naming Conventions

## Primary Keys

Primary keys use the pattern:

`<entity>_id`

### Examples

- `vehicle_id`
- `weather_id`
- `traffic_id`
- `agent_id`
- `date_id`
- `category_id`

---

## Foreign Keys

Foreign keys use the same naming convention as the referenced dimension key.

### Example

`fact_deliveries.vehicle_id → dim_vehicle.vehicle_id`

---

## Boolean Columns

Boolean columns use descriptive prefixes such as:

- `is_`
- `has_`

### Examples

- `is_delayed`
- `is_weekend`

---

# Analytical Metrics

Analytical metrics use descriptive business-oriented naming.

### Examples

- `delivery_time_minutes`
- `delivery_distance_km`
- `delivery_speed_kmh`
- `pickup_prep_minutes`
- `order_hour`

---

# AI Layer Naming

AI layer modules use descriptive agent-oriented naming.

### Examples

- `sql_agent.py`
- `explanation_agent.py`
- `bigquery_tool.py`
- `search_helper.py`
- `demo_app.py`