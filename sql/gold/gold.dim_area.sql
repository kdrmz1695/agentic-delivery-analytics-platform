CREATE TABLE gold.dim_area AS
SELECT
    ROW_NUMBER() OVER (ORDER BY area) AS area_id,
    area
FROM (
    SELECT DISTINCT area
    FROM silver.delivery_cleaned
    WHERE area IS NOT NULL
) t;