CREATE TABLE gold.dim_traffic AS
SELECT
	ROW_NUMBER() OVER(ORDER BY traffic) AS traffic_id, traffic
	FROM(
		SELECT DISTINCT traffic
		FROM silver.delivery_cleaned
		WHERE traffic IS NOT NULL
		AND TRIM(traffic) <> ''
		AND UPPER(TRIM(traffic)) <> 'NAN'
	)t;