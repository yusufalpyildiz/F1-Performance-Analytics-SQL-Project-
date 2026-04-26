# 🏁 F1 Results SQL Analytics Project

## 📌 Overview
This project analyzes Formula 1 race results using SQL.  
It transforms raw race data into structured performance insights for drivers and constructors across all available seasons in the dataset.

The goal is to simulate a real-world sports analytics system by building KPIs such as win rate, consistency, podium finishes, and a custom performance index.

---

## 📊 Key Analyses

### 🏆 Season & Championship Analysis
- Season-based driver standings (total points)
- Season champions using ranking logic (ROW_NUMBER)
- Constructor championship standings

---

### 🏁 Race Performance
- Race winners (drivers & constructors)
- Podium finishes (Top 3 per race)
- Race-by-race standings analysis

---

### 📈 Career Performance Metrics
- Total races per driver
- Win counts and win rate (%)
- Top 5 finish counts and ratios
- Average finishing position

---

### 🔥 Consistency & Dominance Analysis
- Top 5 consistency rate
- Long-term performance comparison across all seasons
- Driver stability scoring

---

### ⚡ Custom Performance Index (Advanced Metric)

A weighted scoring system combining:
- Win rate (50%)
- Top 5 rate (30%)
- Average finishing position impact

This produces a single **performance index** used to rank drivers.

---

## 🧠 SQL Concepts Used
- GROUP BY aggregations  
- CASE WHEN logic  
- CTE (Common Table Expressions)  
- Window functions (ROW_NUMBER)  
- Aggregate functions (SUM, COUNT, AVG)  
- Filtering (WHERE, BETWEEN)  
- Ranking systems  

---

## 🗂️ Data Preparation
- Created staging table (`f1_results_staging`) from raw dataset  
- Removed unnecessary columns (`driver_id`, `constructor_id`)  
- Standardized dataset for analytics  

---

## 📌 Example Insights
- Most dominant drivers by wins  
- Most consistent drivers (Top 5 finishes)  
- Performance ranking system (custom index)  
- Constructor dominance analysis  
- Season-based championship logic  

---

## 🚀 Project Outcome
This project demonstrates how raw Formula 1 data can be transformed into a full analytical system using SQL.

It replicates a simplified sports analytics pipeline used in real-world data analysis environments.

---
