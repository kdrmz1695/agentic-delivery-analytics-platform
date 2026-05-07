CREATE TABLE gold.fact_deliveries AS
SELECT
    s.order_id,

    d.date_id,
    w.weather_id,
    t.traffic_id,
    a.area_id,
    c.category_id,
	v.vehicle,
    ag.agent_id,

    s.order_time,
    s.pickup_time,
    s.order_hour,

    s.delivery_time_minutes,
    s.pickup_prep_minutes,
    s.delivery_distance_km,
    s.delivery_speed_kmh,
    s.is_delayed

FROM silver.delivery_cleaned s

INNER JOIN gold.dim_weather w
    ON s.weather = w.weather

INNER JOIN gold.dim_traffic t
    ON s.traffic = t.traffic

INNER JOIN gold.dim_area a
    ON s.area = a.area

INNER JOIN gold.dim_category c
    ON s.category = c.category

INNER JOIN gold.dim_date d
    ON s.order_date = d.order_date

INNER JOIN gold.dim_vehicle v
	ON s.vehicle = v.vehicle

INNER JOIN gold.dim_agent ag
    ON s.agent_age = ag.agent_age
   AND s.agent_rating = ag.agent_rating;