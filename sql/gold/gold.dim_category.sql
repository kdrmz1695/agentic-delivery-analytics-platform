CREATE TABLE gold.dim_category AS
SELECT
	ROW_NUMBER() OVER (ORDER BY category) AS category_id, category
	FROM(
		SELECT DISTINCT category FROM silver.delivery_cleaned
		WHERE category IS NOT NULL
		AND TRIM(category) <> ''
		AND UPPER(TRIM(category)) <> 'NAN'
	) t;