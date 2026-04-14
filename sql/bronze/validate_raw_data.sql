SELECT * FROM bronze.raw_delivery_data

--Check CSV's row count and bronze table's row

SELECT COUNT(*) FROM bronze.raw_delivery_data;

--Check Primary-like spaces

SELECT COUNT(*) FROM bronze.raw_delivery_data
WHERE "Order_ID" IS NULL;

--Check Duplicates

SELECT "Order_ID", COUNT(*) 
FROM bronze.raw_delivery_data
GROUP BY "Order_ID"
HAVING COUNT(*) >1;