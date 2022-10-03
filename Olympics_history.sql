--------To view the data------------
SELECT * FROM athlete_events
SELECT * FROM noc_regions
SELECT * FROM athlete_events INNER JOIN noc_regions
ON athlete_events.NOC = noc_regions.NOC

------How many olympics games have been held-----------
SELECT COUNT(distinct(Games)) FROM athlete_events   --51

------Olympic games held till now----------------------
SELECT DISTINCT Year,Season,City FROM athlete_events
ORDER BY Year


-----Total number of nations participated---------------
SELECT Year,Games,COUNT(DISTINCT(region))
FROM athlete_events INNER JOIN noc_regions
ON athlete_events.NOC = noc_regions.NOC
GROUP BY Year,Games


------Year with the highest and lowest number of countries participating in olympics-------------- 
With P1 as(
SELECT TOP 1 Year as lowest_year,COUNT(DISTINCT(region)) as min_count_reg
FROM athlete_events INNER JOIN noc_regions
ON athlete_events.NOC = noc_regions.NOC
GROUP BY Year
),

P2 as(SELECT TOP 1 Year as highest_year,COUNT(DISTINCT(region)) as max_count_reg
FROM athlete_events INNER JOIN noc_regions
ON athlete_events.NOC = noc_regions.NOC
GROUP BY Year
ORDER BY Year Desc
)

Select lowest_year,MIN(min_count_reg)as Lowest_no_of_countries,highest_year,MAX(max_count_reg) as Highest_no_of_countries
FROM P1,P2
GROUP BY lowest_year,highest_year


------Which nation participated in all the Olympic games----------------
SELECT region,Count(DISTINCT Games) 
FROM athlete_events INNER JOIN noc_regions
ON athlete_events.NOC = noc_regions.NOC
GROUP BY region
HAVING Count(DISTINCT Games) = (SELECT COUNT(DISTINCT Games) FROM athlete_events

                                
--------Sport played in all summer Olympics---------------------
SELECT DISTINCT Sport,COUNT(DISTINCT Games) from athlete_events
where Season = 'Summer'
Group by Sport 
HAVING COUNT(DISTINCT Games) = (SELECT COUNT(DISTINCT Games) FROM athlete_events where Season='Summer')


----------Sport played only once in Olympics-------------------
SELECT sub.Sport,COUNT(sub.Sport) FROM 
(SELECT DISTINCT Sport, Year FROM athlete_events) sub
GROUP BY sub.Sport
Having COUNT(sub.Sport) = 1

                                
------------Total number of sports played in each Olympic game--------------
SELECT DISTINCT Games,COUNT(DISTINCT Sport) AS no_of_sports FROM athlete_events
GROUP BY Games
ORDER BY no_of_sports DESC

                                
------------Oldest athletes to win a gold medal--------------------
SELECT * 
FROM (SELECT *, DENSE_RANK() OVER(ORDER BY age DESC) AS rank
FROM athlete_events
WHERE medal = 'Gold' )sub
WHERE rank = 1

                                
------------Ratio of male and female athletes who participated in all Olympic games-------------
With t1 (div)
AS(
SELECT CAST (sub.count_male AS float) / CAST(sub.count_female AS float) AS div
FROM (SELECT COUNT(DISTINCT Games) AS count_games,
           SUM(CASE WHEN Sex = 'M' THEN 1 ELSE 0 END) AS count_male,
		   SUM(CASE WHEN Sex = 'F' THEN 1 ELSE 0 END) AS count_female
       FROM athlete_events) sub)

SELECT CONCAT ('1 : ', round(div,2)) AS ratio_gender 
FROM t1

                                
----------------Top 5 athletes who won the gold medals-------------------
With t1(name,team,rank,medal_count)
AS(
SELECT name,team,DENSE_RANK() OVER(ORDER BY medal_count DESC) AS rank, medal_count
FROM (SELECT Name,team,COUNT(Medal) AS medal_count
FROM athlete_events
WHERE Medal = 'Gold'
GROUP BY Name, team
) sub)

SELECT name, team, medal_count 
FROM t1
WHERE rank <= 5

                                
----------Identify which country won the most gold, most silver and most bronze medals in each olympic---------------------------
WITH t1(Games, region, no_gold, no_silver, no_bronze)
AS(SELECT Games, region, SUM (CASE WHEN medal = 'gold' THEN 1 ELSE 0 END) AS no_gold,
				SUM (CASE WHEN medal = 'silver' THEN 1 ELSE 0 END) AS no_silver,
				SUM (CASE WHEN medal = 'bronze' THEN 1 ELSE 0 END) AS no_bronze
FROM athlete_events AS o
JOIN noc_regions AS r
ON o.NOC = r.NOC
GROUP BY Games, region) 

SELECT Distinct Games,
CONCAT ((FIRST_VALUE (region) OVER (PARTITION BY Games ORDER BY no_gold DESC)), 
		' - ', FIRST_VALUE (no_gold) OVER (PARTITION BY Games ORDER BY no_gold DESC)) AS Max_gold,
CONCAT ((FIRST_VALUE (region) OVER (PARTITION BY Games ORDER BY no_silver DESC)),
		' - ', FIRST_VALUE (no_silver) OVER (PARTITION BY Games ORDER BY no_silver DESC)) AS Max_silver,
CONCAT ((FIRST_VALUE (region) OVER (PARTITION BY Games ORDER BY no_bronze DESC)),
		' - ', FIRST_VALUE (no_bronze) OVER (PARTITION BY Games ORDER BY no_bronze DESC)) AS Max_bronze
FROM t1
ORDER BY games



