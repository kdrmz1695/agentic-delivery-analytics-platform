CREATE TABLE gold.dim_vehicle AS
SELECT
    ROW_NUMBER() OVER (ORDER BY vehicle) AS vehicle_id,
    vehicle
FROM (
    SELECT DISTINCT vehicle
    FROM silver.delivery_cleaned
    WHERE vehicle IS NOT NULL
) t;