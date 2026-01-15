CREATE DATABASE air_quality_db;
USE air_quality_db;


CREATE TABLE urban_air_quality (
    city VARCHAR(50),
    date DATE,
    year INT,
    month INT,
    day INT,
    pm2_5 INT,
    pm10 INT,
    no2 INT,
    so2 INT,
    co DECIMAL(4,2),
    AQI INT,
    AQI_Status VARCHAR(20),
    Health_Risk INT
);

SELECT * FROM urban_air_quality;

# QUERIES TO KNOW

#1. Overall Air Quality Severity (Big Picture)

SELECT 
  AQI_Status,
  COUNT(*) AS days_count,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM urban_air_quality), 2) AS percentage
FROM urban_air_quality
GROUP BY AQI_Status
ORDER BY days_count DESC;


#2. Worst Pollution Days (Critical Question)

SELECT 
  date, city, AQI, AQI_Status, Health_Risk
FROM urban_air_quality
ORDER BY AQI DESC
LIMIT 10;

#3. Monthly AQI Trend (Seasonality)

SELECT 
  month,
  ROUND(AVG(AQI), 1) AS avg_aqi
FROM urban_air_quality
GROUP BY month
ORDER BY month;

#4. Health Risk vs AQI Relationship (High-Value Insight)

SELECT 
  AQI_Status,
  ROUND(AVG(Health_Risk), 1) AS avg_health_risk
FROM urban_air_quality
GROUP BY AQI_Status
ORDER BY avg_health_risk DESC;

#5. City-wise Air Quality Ranking

SELECT 
  city,
  ROUND(AVG(AQI), 1) AS avg_aqi
FROM urban_air_quality
GROUP BY city
ORDER BY avg_aqi DESC;

#6. Pollutant Contribution (Very Important)

SELECT
  ROUND(AVG(pm2_5),1) AS avg_pm2_5,
  ROUND(AVG(pm10),1) AS avg_pm10,
  ROUND(AVG(no2),1) AS avg_no2,
  ROUND(AVG(so2),1) AS avg_so2,
  ROUND(AVG(co),2) AS avg_co
FROM urban_air_quality;

#7. Extreme Pollution Frequency

SELECT 
  COUNT(*) AS very_poor_days
FROM urban_air_quality
WHERE AQI_Status = 'Very Poor';

#8. Best vs Worst Days Comparison (Simple but Powerful)

SELECT
  MIN(AQI) AS best_aqi,
  MAX(AQI) AS worst_aqi,
  ROUND(AVG(AQI),1) AS avg_aqi
FROM urban_air_quality;

#9. Weekend vs Weekday Pollution (Smart Insight)

SELECT
  CASE 
    WHEN DAYOFWEEK(date) IN (1,7) THEN 'Weekend'
    ELSE 'Weekday'
  END AS day_type,
  ROUND(AVG(AQI),1) AS avg_aqi
FROM urban_air_quality
GROUP BY day_type;

#10. Month-wise Health Risk Trend

SELECT 
  month,
  ROUND(AVG(Health_Risk),1) AS avg_health_risk
FROM urban_air_quality
GROUP BY month
ORDER BY month;


