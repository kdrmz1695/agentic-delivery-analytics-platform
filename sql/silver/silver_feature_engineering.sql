TRUNCATE TABLE silver.delivery_cleaned;

WITH base AS (
    SELECT
        "Order_ID" AS order_id,
        "Agent_Age" AS agent_age,
        "Agent_Rating" AS agent_rating,
        "Store_Latitude" AS store_latitude,
        "Store_Longitude" AS store_longitude,
        "Drop_Latitude" AS drop_latitude,
        "Drop_Longitude" AS drop_longitude,
        TO_DATE("Order_Date", 'DD-MM-YYYY') AS order_date,

        CASE
            WHEN TRIM("Order_Time") IN ('NaN', '') THEN NULL
            ELSE CAST(TRIM("Order_Time") AS TIME)
        END AS order_time,

        CASE
            WHEN TRIM("Pickup_Time") IN ('NaN', '') THEN NULL
            ELSE CAST(TRIM("Pickup_Time") AS TIME)
        END AS pickup_time,

        TRIM("Weather") AS weather,
        TRIM("Traffic") AS traffic,
        TRIM("Vehicle") AS vehicle,
        TRIM("Area") AS area,
        TRIM("Category") AS category,
        "Delivery_Time" AS delivery_time_minutes,

        (
            6371 * ACOS(
                COS(RADIANS("Store_Latitude")) * COS(RADIANS("Drop_Latitude")) *
                COS(RADIANS("Drop_Longitude") - RADIANS("Store_Longitude")) +
                SIN(RADIANS("Store_Latitude")) * SIN(RADIANS("Drop_Latitude"))
            )
        )::NUMERIC(10,3) AS raw_delivery_distance_km,

        CASE
            WHEN "Delivery_Time" > 30 THEN TRUE
            ELSE FALSE
        END AS is_delayed

    FROM bronze.raw_delivery_data
    WHERE "Order_ID" IS NOT NULL
),

cleaned AS (
    SELECT
        *,
        CASE
            WHEN raw_delivery_distance_km > 25 THEN NULL
            ELSE raw_delivery_distance_km
        END AS delivery_distance_km
    FROM base
)

INSERT INTO silver.delivery_cleaned (
    order_id,
    agent_age,
    agent_rating,
    store_latitude,
    store_longitude,
    drop_latitude,
    drop_longitude,
    order_date,
    order_time,
    pickup_time,
    weather,
    traffic,
    vehicle,
    area,
    category,
    delivery_time_minutes,
    order_hour,
    order_weekday,
    is_weekend,
    pickup_prep_minutes,
    delivery_distance_km,
    delivery_speed_kmh,
    is_delayed
)
SELECT
    order_id,
    agent_age,
    agent_rating,
    store_latitude,
    store_longitude,
    drop_latitude,
    drop_longitude,
    order_date,
    order_time,
    pickup_time,
    weather,
    traffic,
    vehicle,
    area,
    category,
    delivery_time_minutes,

    EXTRACT(HOUR FROM order_time)::INTEGER AS order_hour,

    TO_CHAR(order_date, 'FMDay') AS order_weekday,

    CASE
        WHEN EXTRACT(ISODOW FROM order_date) IN (6, 7) THEN TRUE
        ELSE FALSE
    END AS is_weekend,

    CASE
        WHEN order_time IS NULL OR pickup_time IS NULL THEN NULL
        WHEN pickup_time >= order_time
            THEN EXTRACT(EPOCH FROM (pickup_time - order_time)) / 60
        ELSE
            EXTRACT(EPOCH FROM (
                (pickup_time::INTERVAL + INTERVAL '24 hours') - order_time::INTERVAL
            )) / 60
    END::INTEGER AS pickup_prep_minutes,

    delivery_distance_km,

    CASE
        WHEN delivery_distance_km IS NULL THEN NULL
        WHEN delivery_time_minutes > 0
            THEN ROUND(((delivery_distance_km * 60.0) / delivery_time_minutes)::NUMERIC, 3)
        ELSE NULL
    END AS delivery_speed_kmh,

    is_delayed
FROM cleaned;