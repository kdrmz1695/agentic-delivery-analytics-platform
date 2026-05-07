CREATE TABLE gold.dim_agent AS
SELECT
    ROW_NUMBER() OVER (ORDER BY agent_age, agent_rating) AS agent_id,
    agent_age,
    agent_rating
FROM (
    SELECT DISTINCT
        agent_age,
        agent_rating
    FROM silver.delivery_cleaned
    WHERE agent_age IS NOT NULL
      AND agent_rating IS NOT NULL
) t;