CREATE TABLE gold.dim_weather AS
SELECT
	ROW_NUMBER() OVER (ORDER BY weather) AS weather_id, weather
FROM(
	SELECT DISTINCT weather FROM silver.delivery_cleaned
	WHERE weather IS NOT NULL
	 AND TRIM(weather) <> ''
	 AND UPPER(TRIM(weather)) <> 'NAN'
	) t ;