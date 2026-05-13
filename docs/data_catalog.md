# Data Catalog

## Overview

This document describes the Gold Layer analytical tables used in the Agentic Delivery Analytics Platform.

The Gold Layer is designed using a star schema architecture to support:

- AI-based querying
- Business analytics
- Dashboard visualization
- Natural language interaction
- Text-to-SQL generation

The dataset is optimized for analytical workloads and AI agent consumption through BigQuery.

---

# gold.fact_deliveries

Central fact table containing delivery-level operational metrics.

## Columns

| Column Name | Description |
|---|---|
| order_id | Unique identifier for each delivery order |
| date_id | Foreign key to dim_date |
| agent_id | Foreign key to dim_agent |
| vehicle_id | Foreign key to dim_vehicle |
| weather_id | Foreign key to dim_weather |
| traffic_id | Foreign key to dim_traffic |
| area_id | Foreign key to dim_area |
| category_id | Foreign key to dim_category |
| order_time | Order creation timestamp |
| pickup_time | Pickup timestamp |
| order_hour | Extracted order hour |
| delivery_time_minutes | Total delivery duration in minutes |
| pickup_prep_minutes | Preparation duration before pickup |
| delivery_distance_km | Delivery distance in kilometers |
| delivery_speed_kmh | Estimated delivery speed |
| is_delayed | Delivery delay indicator |

---

# gold.dim_agent

Dimension table containing delivery agent information.

## Columns

| Column Name | Description |
|---|---|
| agent_id | Unique delivery agent identifier |
| agent_age | Age of delivery agent |
| agent_rating | Delivery agent performance rating |

---

# gold.dim_area

Dimension table containing delivery area information.

## Columns

| Column Name | Description |
|---|---|
| area_id | Unique area identifier |
| area | Delivery region category |

---

# gold.dim_category

Dimension table containing order category information.

## Columns

| Column Name | Description |
|---|---|
| category_id | Unique category identifier |
| category | Food or delivery category |

---

# gold.dim_date

Dimension table containing calendar-based delivery attributes.

## Columns

| Column Name | Description |
|---|---|
| date_id | Unique date identifier |
| order_date | Delivery order date |
| order_weekday | Weekday extracted from order date |
| is_weekend | Weekend indicator flag |

---

# gold.dim_vehicle

Dimension table containing delivery vehicle information.

## Columns

| Column Name | Description |
|---|---|
| vehicle_id | Unique vehicle identifier |
| vehicle | Delivery vehicle type |

---

# gold.dim_weather

Dimension table containing weather condition information.

## Columns

| Column Name | Description |
|---|---|
| weather_id | Unique weather identifier |
| weather | Weather condition category |

---

# gold.dim_traffic

Dimension table containing traffic condition information.

## Columns

| Column Name | Description |
|---|---|
| traffic_id | Unique traffic identifier |
| traffic | Traffic congestion category |

---

# Data Model

The Gold Layer follows a star schema design:

- One central fact table
- Multiple surrounding dimension tables
- One row per delivery/order in the fact table

This structure is optimized for:

- Analytical SQL queries
- AI-powered querying
- Dashboard reporting
- Aggregation workloads
- Retrieval-Augmented Generation (RAG)