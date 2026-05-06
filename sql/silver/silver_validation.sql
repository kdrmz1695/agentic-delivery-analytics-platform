/*

Validation: Data & Feature Correctness

*/

-- Row Count Check
-- Expectation: row_count values should be same.

SELECT 'bronze' AS layer, COUNT(*) AS row_count
FROM bronze.raw_delivery_data
WHERE "Order_ID" IS NOT NULL

UNION ALL

SELECT 'silver' AS layer, COUNT(*) AS row_count
FROM silver.delivery_cleaned
WHERE order_id IS NOT NULL;


-- Primary Key Duplication Check
-- Expectation: result should be empty.

SELECT order_id, COUNT(*) AS duplicate_pk
FROM silver.delivery_cleaned
GROUP BY order_id
HAVING COUNT(*) > 1;


-- NULL Check for Critical Columns
-- Expectation: Critical columns should ideally have no NULL values.

SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE order_id IS NULL) AS null_order_id,
    COUNT(*) FILTER (WHERE order_date IS NULL) AS null_order_date,
    COUNT(*) FILTER (WHERE delivery_time_minutes IS NULL) AS null_delivery_time,
    COUNT(*) FILTER (WHERE weather IS NULL) AS null_weather,
    COUNT(*) FILTER (WHERE traffic IS NULL) AS null_traffic,
    COUNT(*) FILTER (WHERE vehicle IS NULL) AS null_vehicle,
    COUNT(*) FILTER (WHERE area IS NULL) AS null_area,
    COUNT(*) FILTER (WHERE category IS NULL) AS null_category
FROM silver.delivery_cleaned;


-- Check order_hour
-- Expectation: order_hour should be between 0 and 23.

SELECT
    MAX(order_hour) AS max_order_hour,
    MIN(order_hour) AS min_order_hour
FROM silver.delivery_cleaned;


-- Feature Range Check
-- Expectation: no negative values, ranges should be reasonable.

SELECT
    MIN(pickup_prep_minutes) AS min_prep_minutes,
    MAX(pickup_prep_minutes) AS max_prep_minutes,
    MIN(delivery_distance_km) AS min_distance_km,
    MAX(delivery_distance_km) AS max_distance_km,
    MIN(delivery_speed_kmh) AS min_speed_kmh,
    MAX(delivery_speed_kmh) AS max_speed_kmh
FROM silver.delivery_cleaned;


-- Negative Feature Check
-- Expectation: result should be empty.

SELECT *
FROM silver.delivery_cleaned
WHERE pickup_prep_minutes < 0
   OR delivery_distance_km < 0
   OR delivery_speed_kmh < 0;


-- Delay Flag Logic Check
-- Expectation: result should be empty.

SELECT *
FROM silver.delivery_cleaned
WHERE (delivery_time_minutes > 30 AND is_delayed = FALSE)
   OR (delivery_time_minutes <= 30 AND is_delayed = TRUE);


-- Speed Outlier Check
-- Expectation: manually review high speed values.

SELECT
    order_id,
    delivery_distance_km,
    delivery_time_minutes,
    delivery_speed_kmh
FROM silver.delivery_cleaned
WHERE delivery_speed_kmh IS NOT NULL
ORDER BY delivery_speed_kmh DESC
LIMIT 20;


-- Category Standardization Check
-- Expectation: values should be clean and consistent.

SELECT DISTINCT weather FROM silver.delivery_cleaned ORDER BY weather;
SELECT DISTINCT traffic FROM silver.delivery_cleaned ORDER BY traffic;
SELECT DISTINCT vehicle FROM silver.delivery_cleaned ORDER BY vehicle;
SELECT DISTINCT area FROM silver.delivery_cleaned ORDER BY area;
SELECT DISTINCT category FROM silver.delivery_cleaned ORDER BY category;