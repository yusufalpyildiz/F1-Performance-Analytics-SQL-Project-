SELECT * 
FROM f1_results;

CREATE TABLE f1_results_staging as 
SELECT *
FROM f1_results;

SELECT * 
FROM f1_results_staging;

ALTER TABLE f1_results_staging
DROP COLUMN constructor_id;

#2026 Australian GP standings
SELECT * 
FROM f1_results_staging
WHERE season = 2026 and
round = 1
ORDER BY position ;

ALTER TABLE f1_results_staging
DROP COLUMN driver_id;


SELECT * 
FROM f1_results_staging
WHERE season = 2025;

#2025 Season Driver Standings
SELECT driver_name, sum(points) as Points
FROM f1_results_staging
WHERE season = 2025
GROUP BY driver_name
ORDER BY 2 DESC;

#2025 Season Constructor Standings
SELECT constructor_name, sum(points) as Points
FROM f1_results_staging
WHERE season = 2025
GROUP BY constructor_name
ORDER BY 2 DESC;

#Every Race Podium Standings
SELECT round, race_name, driver_name, constructor_name, position
FROM f1_results_staging
WHERE season= 2025 AND
position <= 3
ORDER BY round, position asc;

#2020-2026 Most Race Winner Driver
SELECT driver_name, count(position) as racewins
FROM f1_results_staging
WHERE season BETWEEN 2020 AND 2026
AND position = 1
group by driver_name
ORDER BY racewins DESC;

#2020-2026 Most Race Winner Constructor
SELECT constructor_name, count(position) as racewins
FROM f1_results_staging
WHERE season BETWEEN 2020 AND 2026
AND position = 1
group by constructor_name
ORDER BY racewins DESC;	


#Her yılın en iyi pilotu
SELECT season, driver_name, sum(points) as total_points
FROM f1_results_staging
group by season, driver_name 
order by season, total_points DESC;


SELECT season, driver_name, total_points
FROM (
    SELECT 
        season,
        driver_name,
        SUM(points) AS total_points,
        ROW_NUMBER() OVER (
            PARTITION BY season 
            ORDER BY SUM(points) DESC
        ) AS rn
    FROM f1_results_staging
    GROUP BY season, driver_name
) t
WHERE rn = 1
ORDER BY season DESC;

#TAKIMLARIN YARIS KAZANMA SAYILARI
SELECT constructor_name, count(*) as wins
FROM f1_results_staging
WHERE position = 1
group by  constructor_name
ORDER BY wins DESC;


#AVERAGE FINISHING POSITION 2020-2026
SELECT driver_name, AVG(position) as avg_position
FROM f1_results_staging
WHERE season BETWEEN 2020 AND 2026
group by driver_name
ORDER BY avg_position ASC;	


#Top 5 bitirme sayısı
SELECT driver_name, count(*) as races, sum(CASE when position <= 5 THEN 1 ELSE 0 END) AS top5_finishes
FROM f1_results_staging
GROUP BY driver_name
ORDER BY top5_finishes DESC;


#Top 5 bitirme sayıları ve oranları
WITH deneme_cte AS
(
SELECT driver_name, count(*) as races, sum(CASE when position <= 5 THEN 1 ELSE 0 END) AS top5_finishes
FROM f1_results_staging
GROUP BY driver_name
)
SELECT driver_name, races, top5_finishes, top5_finishes/races*100 as top5_finishes_oran
FROM deneme_cte
ORDER BY top5_finishes DESC;

#2021 yılı Top 5 bitirme sayıları ve oranları
WITH deneme_cte AS
(
SELECT season, driver_name, count(*) as races, sum(CASE when position <= 5 THEN 1 ELSE 0 END) AS top5_finishes
FROM f1_results_staging
WHERE season = 2021
GROUP BY driver_name
)
SELECT driver_name, races, top5_finishes, top5_finishes/races*100
FROM deneme_cte
ORDER BY top5_finishes DESC;




#2008-2026 istatistik
WITH base AS
(
	SELECT season, 
    driver_name, 
    count(*) as races,
    SUM(CASE WHEN position = 1 THEN 1 ELSE 0 END) as wins,
    SUM(CASE WHEN position <= 5 THEN 1 ELSE 0 END) as top5,
    AVG(position) as avg_position
    FROM f1_results_staging
    WHERE season BETWEEN 2008 and 2026
    GROUP BY season, driver_name    
)
SELECT season,
driver_name, 
races, 
wins, 
top5, 
avg_position,
ROUND(100.0 * wins / races, 2) as win_rate,
ROUND(100.0 * top5 / races, 2) as top5_rate
FROM base
ORDER BY win_rate DESC;




#2008-2026 istatistik2
WITH base AS
(
	SELECT season, driver_name, 
    count(*) as races,
    SUM(CASE WHEN position = 1 THEN 1 ELSE 0 END) as wins,
    SUM(CASE WHEN position <= 5 THEN 1 ELSE 0 END) as top5,
    AVG(position) as avg_position
    FROM f1_results_staging
    WHERE season BETWEEN 2008 and 2026
    GROUP BY season, driver_name    
)
SELECT season,
driver_name, 
races, 
wins, 
top5, 
avg_position,
ROUND(100.0 * wins / races, 2) as win_rate,
ROUND(100.0 * top5 / races, 2) as top5_rate,
ROUND(
        (100.0 * wins / races) * 0.5 +
        (100.0 * top5 / races) * 0.3 +
        (10 / avg_position) * 10,
    2) AS performance_index
FROM base
ORDER BY performance_index DESC;




