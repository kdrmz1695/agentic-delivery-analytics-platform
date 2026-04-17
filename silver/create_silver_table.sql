DROP TABLE IF EXISTS silver.delivery_cleaned;

CREATE TABLE silver.delivery_cleaned (
    order_id TEXT PRIMARY KEY,
    agent_age INTEGER,
    agent_rating NUMERIC(3,2),
    store_latitude NUMERIC(10,6),
    store_longitude NUMERIC(10,6),
    drop_latitude NUMERIC(10,6),
    drop_longitude NUMERIC(10,6),
    order_date DATE,
    order_time TIME,
    pickup_time TIME,
    weather TEXT,
    traffic TEXT,
    vehicle TEXT,
    area TEXT,
    category TEXT,
    delivery_time_minutes INTEGER,
    order_hour INTEGER,
    order_weekday TEXT,
    is_weekend BOOLEAN,
    pickup_prep_minutes INTEGER,
    delivery_distance_km NUMERIC(10,3),
	delivery_speed_kmh NUMERIC(10,3),
    is_delayed BOOLEAN
);