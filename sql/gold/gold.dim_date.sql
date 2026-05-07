CREATE TABLE gold.dim_date AS
SELECT
    ROW_NUMBER() OVER (ORDER BY order_date) AS date_id,
    order_date,
    order_weekday,
    is_weekend
FROM (
    SELECT DISTINCT
        order_date,
        order_weekday,
        is_weekend
    FROM silver.delivery_cleaned
    WHERE order_date IS NOT NULL
) t;