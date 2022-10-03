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
SELECT Games,Sport,COUNT(Sport) FROM athlete_events
WHERE Count


