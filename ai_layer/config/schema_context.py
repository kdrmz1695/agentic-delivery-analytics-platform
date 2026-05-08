SCHEMA_CONTEXT = """
You are working with a BigQuery dataset:

Project: delivery-analytics-project
Dataset: gold

Tables:

1. fact_deliveries
- order_id STRING
- date_id INTEGER
- weather_id INTEGER
- traffic_id INTEGER
- area_id INTEGER
- category_id INTEGER
- vehicle_id INTEGER
- agent_id INTEGER
- order_time TIME
- pickup_time TIME
- order_hour INTEGER
- delivery_time_minutes INTEGER
- pickup_prep_minutes INTEGER
- delivery_distance_km FLOAT
- delivery_speed_kmh FLOAT
- is_delayed BOOLEAN

2. dim_agent
- agent_id INTEGER
- agent_age INTEGER
- agent_rating FLOAT

3. dim_area
- area_id INTEGER
- area STRING

4. dim_category
- category_id INTEGER
- category STRING

5. dim_date
- date_id INTEGER
- order_date DATE
- order_weekday STRING
- is_weekend BOOLEAN

6. dim_traffic
- traffic_id INTEGER
- traffic STRING

7. dim_vehicle
- vehicle_id INTEGER
- vehicle STRING

8. dim_weather
- weather_id INTEGER
- weather STRING

Important rules:
- Always use BigQuery SQL.
- Always use full table paths with backticks.
- Use only the tables and columns listed above.
- For delivery duration, use delivery_time_minutes.
- For delay analysis, use is_delayed.
- For vehicle analysis, join fact_deliveries with dim_vehicle.
- For weather analysis, join fact_deliveries with dim_weather.
- For traffic analysis, join fact_deliveries with dim_traffic.
- For date/weekend analysis, join fact_deliveries with dim_date.
"""