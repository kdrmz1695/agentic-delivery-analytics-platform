/* Validation For Gold Layer: 
*/

--Expectation: Row numbers are same
-- Result: %0.33 loss. Filtered 'NaN' values
SELECT COUNT(*) AS silver_count
FROM silver.delivery_cleaned;

SELECT COUNT(*) AS fact_count
FROM gold.fact_deliveries;

--Expectation: No Null ID
--Result: 0 null
SELECT
    COUNT(*) FILTER (WHERE date_id IS NULL) AS null_date_id,
    COUNT(*) FILTER (WHERE weather_id IS NULL) AS null_weather_id,
    COUNT(*) FILTER (WHERE traffic_id IS NULL) AS null_traffic_id,
    COUNT(*) FILTER (WHERE area_id IS NULL) AS null_area_id,
    COUNT(*) FILTER (WHERE category_id IS NULL) AS null_category_id,
    COUNT(*) FILTER (WHERE vehicle_id IS NULL) AS null_vehicle_id,
    COUNT(*) FILTER (WHERE agent_id IS NULL) AS null_agent_id
FROM gold.fact_deliveries;