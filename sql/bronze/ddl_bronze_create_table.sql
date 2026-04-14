/*
===============================================================================
DDL Script: Create Bronze Table
===============================================================================
Script Purpose:
    This script creates the raw bronze table in the 'bronze' schema.
    If the table already exists, it will be dropped and recreated.
===============================================================================
*/

DROP TABLE IF EXISTS bronze.raw_delivery_data;

CREATE TABLE bronze.raw_delivery_data (
    "Order_ID" TEXT,
    "Agent_Age" INTEGER,
    "Agent_Rating" NUMERIC(3,2),
    "Store_Latitude" NUMERIC(10,6),
    "Store_Longitude" NUMERIC(10,6),
    "Drop_Latitude" NUMERIC(10,6),
    "Drop_Longitude" NUMERIC(10,6),
    "Order_Date" TEXT,
    "Order_Time" TEXT,
    "Pickup_Time" TEXT,
    "Weather" TEXT,
    "Traffic" TEXT,
    "Vehicle" TEXT,
    "Area" TEXT,
    "Delivery_Time" INTEGER,
    "Category" TEXT
);