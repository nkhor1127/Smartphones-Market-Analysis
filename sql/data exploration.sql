-- Create table based on cleaned csv
CREATE TABLE smartphones (
    brand_name VARCHAR(50),
    model VARCHAR(100),
    price INT,
    avg_rating FLOAT,
    "5G_or_not" INT,
    processor_brand VARCHAR(50),
    num_cores FLOAT,
    processor_speed FLOAT,
    battery_capacity FLOAT,
    fast_charging_available INT,
    fast_charging FLOAT,
    ram_capacity INT,
    internal_memory INT,
    screen_size FLOAT,
    refresh_rate INT,
    num_rear_cameras INT,
    os VARCHAR(50),
    primary_camera_rear FLOAT,
    primary_camera_front FLOAT,
    extended_memory_available INT,
    resolution_height INT,
    resolution_width INT
);

-- Check smartphones table
SELECT * 
FROM smartphones;

-- Count total rows
SELECT COUNT(*) FROM smartphones;

-- Unique brands, OS types, processors count
SELECT COUNT(DISTINCT brand_name) AS unique_brands, 
	   COUNT(DISTINCT os) AS unique_os_types,
	   COUNT(DISTINCT processor_brand) AS unique_processors
FROM smartphones; 

-- Brand comparison 
SELECT brand_name,
       COUNT(*) AS num_models,
       ROUND(AVG(price)::numeric, 2) AS avg_price,
       ROUND(AVG(avg_rating)::numeric, 2) AS avg_rating,
       ROUND(AVG(ram_capacity)::numeric, 1) AS avg_ram,
       ROUND(AVG(battery_capacity)::numeric, 0) AS avg_battery
FROM smartphones
GROUP BY brand_name
ORDER BY avg_price DESC;

-- Brands according to rating
SELECT brand_name,
       ROUND(AVG(price)::numeric, 2) AS avg_price,
	   ROUND(AVG(avg_rating)::numeric, 2) AS avg_rating, 
	   COUNT(*) AS num_models
FROM smartphones
WHERE avg_rating IS NOT NULL
GROUP BY brand_name
ORDER BY avg_rating DESC;

-- Average specs (RAM and battery capacity) by OS 
SELECT os, 
	   ROUND(AVG(price)::numeric, 2) AS avg_price,
	   ROUND(AVG(ram_capacity)::numeric, 1) AS avg_ram,
	   ROUND(AVG(battery_capacity)::numeric, 0) AS avg_battery
FROM smartphones
GROUP BY os
ORDER BY avg_price DESC;

-- 5G vs Non-5G Price comparison
SELECT "5G_or_not",
       COUNT(*) AS num_models,
	   ROUND(AVG(price)::numeric, 2) AS avg_price,
	   ROUND(AVG(ram_capacity)::numeric, 1) AS avg_ram
FROM smartphones
GROUP BY "5G_or_not"
ORDER BY avg_price DESC;

-- Price range and portfolio analysis by brand
SELECT brand_name,
       MIN(price) AS min_price,
	   MAX(price) AS max_price,
	   ROUND(AVG(price)::numeric, 2) AS avg_price,
	   MAX(price) - MIN(price) AS price_range,
	   COUNT(*) AS num_models
FROM smartphones
GROUP BY brand_name
ORDER BY price_range DESC;

-- Relationship between price and specs (RAM vs Price)
SELECT ram_capacity,
	   ROUND(AVG(price)::numeric, 2) AS avg_price,
	   COUNT(*) AS num_models
FROM smartphones
GROUP BY ram_capacity
ORDER BY ram_capacity;

-- Relationship between price and specs (Processor Speed vs Price)
SELECT ROUND(processor_speed::numeric, 1) AS processor_speed,
	   ROUND(AVG(price)::numeric, 2) AS avg_price,
	   COUNT(*) AS num_models
FROM smartphones
WHERE processor_speed IS NOT NULL
GROUP BY ROUND(processor_speed::numeric, 1)
ORDER BY processor_speed;

-- Top 10 most rated models
SELECT model, brand_name, avg_rating, price
FROM smartphones
WHERE avg_rating IS NOT NULL
ORDER BY avg_rating DESC
LIMIT 10;

-- Top 10 most expensive models
SELECT model, brand_name, price, ram_capacity, battery_capacity, primary_camera_rear, processor_speed
FROM smartphones
ORDER BY price DESC
LIMIT 10;

-- Underperforming models (low rating with high price)
SELECT model, brand_name, price, avg_rating
FROM smartphones
WHERE avg_rating < 7.0 AND price > 30000
ORDER BY price DESC;

-- Models with 5G support
SELECT model, brand_name, "5G_or_not"
FROM smartphones
WHERE "5G_or_not" = 1;

-- Models with fast charging
SELECT model, brand_name, fast_charging_available
FROM smartphones
WHERE fast_charging_available = 1;

-- Models with at least 8GB RAM
SELECT model, brand_name, ram_capacity
FROM smartphones
WHERE ram_capacity >= 8
ORDER BY ram_capacity DESC;

-- Models with 5G support, fast charging, and >= 8GB RAM
SELECT model, brand_name, "5G_or_not", fast_charging_available, ram_capacity
FROM smartphones
WHERE "5G_or_not" = 1
	AND fast_charging_available = 1
	AND ram_capacity >= 8
ORDER BY ram_capacity DESC;
