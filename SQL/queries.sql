-- ================================================
-- FOUNDER CUSTOMER INTELLIGENCE SYSTEM
-- SQL Segmentation Queries
-- Database: d2c_customer_intelligence | Table: d2c_customers
-- Author: Akshit Sukhija & Bhumika Singhal
-- Project: IIT Guwahati — Summer Project
-- ================================================


-- ================================================
-- DATABASE SETUP
-- ================================================

CREATE DATABASE d2c_customer_intelligence;
USE d2c_customer_intelligence;


-- ================================================
-- PRE-ANALYSIS: TABLE & COLUMN PREPARATION
-- Rename table and clean column names to remove
-- spaces and special characters before querying
-- ================================================

ALTER TABLE refined_customer_intelligence_engine_output
    RENAME TO d2c_customers;

ALTER TABLE d2c_customers
    RENAME COLUMN `Purchase Amount (USD)`  TO Purchase_Amount_USD;

ALTER TABLE d2c_customers
    RENAME COLUMN `Previous Purchases`     TO Previous_Purchases;

ALTER TABLE d2c_customers
    RENAME COLUMN `Subscription Status`    TO Subscription_Status;


-- ================================================
-- Q1: LOYAL VS PROMO BUYERS
-- Who are genuinely loyal customers vs
-- those who only buy with discounts?
-- ================================================

SELECT
    Master_Customer_Segment,
    COUNT(*)                                AS Total_Customers,
    ROUND(AVG(Promo_Dependency_Score), 2)   AS Avg_Promo_Dependency,
    ROUND(AVG(Loyalty_Score_A), 2)          AS Avg_Behavioral_Loyalty,
    ROUND(AVG(Loyalty_Score_B), 2)          AS Avg_Commercial_Loyalty,
    ROUND(AVG(Purchase_Amount_USD), 2)      AS Avg_Customer_Spend
FROM d2c_customers
GROUP BY Master_Customer_Segment
ORDER BY Avg_Behavioral_Loyalty DESC;


-- ================================================
-- Q2: CUSTOMER VALUE TIER BREAKDOWN
-- What behavioral patterns predict high
-- customer value over time?
-- ================================================

SELECT
    Customer_Value_Tier,
    ROUND(AVG(Purchase_Intensity_Score), 2)  AS Avg_Purchase_Intensity,
    ROUND(AVG(Review_Satisfaction_Score), 2) AS Avg_Satisfaction,
    ROUND(AVG(Promo_Dependency_Score), 2)    AS Avg_Promo_Dependency,
    ROUND(AVG(Previous_Purchases), 1)        AS Avg_Previous_Purchases,
    COUNT(*)                                 AS Customer_Count
FROM d2c_customers
GROUP BY Customer_Value_Tier
ORDER BY Avg_Purchase_Intensity DESC;


-- ================================================
-- Q3: GEOGRAPHIC DEMAND INTELLIGENCE
-- Which geographies signal organic demand
-- vs discount-driven volume?
-- ================================================

SELECT
    Location,
    COUNT(*)                                                        AS Total_Customers,
    ROUND(AVG(Purchase_Amount_USD), 2)                              AS Avg_Spend,
    ROUND(AVG(Promo_Dependency_Score), 2)                           AS Avg_Promo_Dependency,
    SUM(CASE WHEN Master_Customer_Segment = 'Premium Loyalists'
             THEN 1 ELSE 0 END)                                     AS Premium_Loyalists,
    ROUND(
        100.0 * SUM(CASE WHEN Master_Customer_Segment = 'Premium Loyalists'
                         THEN 1 ELSE 0 END) / COUNT(*), 1
    )                                                               AS Premium_Pct
FROM d2c_customers
GROUP BY Location
ORDER BY Avg_Spend DESC, Avg_Promo_Dependency ASC
LIMIT 10;


-- ================================================
-- Q4: PROMOTIONAL SUNSET PLAN
-- How should the brand restructure its
-- promotional strategy to protect margins?
-- ================================================

SELECT
    Master_Customer_Segment,
    COUNT(*)                                    AS Customer_Count,
    ROUND(AVG(Promo_Dependency_Score), 2)       AS Avg_Promo_Dependency,
    ROUND(AVG(Purchase_Amount_USD), 2)          AS Avg_Spend,
    ROUND(AVG(Loyalty_Score_A), 2)              AS Behavioral_Loyalty,
    CASE
        WHEN AVG(Promo_Dependency_Score) >= 0.75
             AND AVG(Loyalty_Score_A) < 0.50    THEN 'Sunset Discounts — Low loyalty risk'
        WHEN AVG(Promo_Dependency_Score) >= 0.50
             AND AVG(Loyalty_Score_A) >= 0.50   THEN 'Reduce Gradually — Monitor retention'
        WHEN AVG(Promo_Dependency_Score) < 0.40 THEN 'Protect — Organically loyal'
        ELSE                                         'Review Case by Case'
    END                                         AS Promo_Recommendation
FROM d2c_customers
GROUP BY Master_Customer_Segment
ORDER BY Avg_Promo_Dependency DESC;


-- ================================================
-- Q5: IDEAL CUSTOMER PROFILE
-- What does the brand's best customer
-- actually look like?
-- ================================================

SELECT
    Gender,
    ROUND(AVG(Age), 1)                  AS Avg_Age,
    Location,
    Category,
    Subscription_Status,
    Season,
    ROUND(AVG(Purchase_Amount_USD), 2)  AS Avg_Spend,
    ROUND(AVG(Previous_Purchases), 1)   AS Avg_Purchases,
    ROUND(AVG(Loyalty_Score_A), 2)      AS Behavioral_Loyalty,
    COUNT(*)                            AS Customer_Count
FROM d2c_customers
WHERE Master_Customer_Segment = 'Premium Loyalists'
GROUP BY Gender, Location, Category, Subscription_Status, Season
ORDER BY Avg_Spend DESC, Behavioral_Loyalty DESC
LIMIT 20;
