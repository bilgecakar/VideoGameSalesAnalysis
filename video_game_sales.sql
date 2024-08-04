--1. What are the top 10 games by global sales?
SELECT
name, 
global_sales
FROM video_game_sales
ORDER BY global_sales DESC
LIMIT 10

--2. Which platform has the most games in the top 100 global sales?

SELECT 
platform, 
COUNT(*) AS game_count,
SUM(global_sales) AS total_sales
FROM video_game_sales
GROUP BY platform
ORDER BY total_sales DESC, game_count DESC
LIMIT 100

--3. What are the total sales in North America, Europe, Japan, and other regions?

SELECT 
SUM(na_sales) AS na_total_sales,
SUM(eu_sales) AS eu_total_sales,
SUM(jp_sales) AS jp_total_sales,
SUM(other_sales) AS other_total_sales
FROM video_game_sales

--4. What is the average global sales per genre?
	
SELECT 
genre,
ROUND(AVG(global_sales)::numeric,2) AS average_global_sales
FROM video_game_sales
GROUP BY  genre 
ORDER BY average_global_sales DESC


--5. Which publisher has the highest average global sales per game?

SELECT 
publisher, 
ROUND(AVG(global_sales)::numeric,2) AS average_global_sales
FROM video_game_sales
GROUP BY publisher
ORDER BY average_global_sales DESC
LIMIT 10

--6. What are the total sales by year?

SELECT
year,
SUM(global_sales) AS total_sales
FROM video_game_sales
GROUP BY year
ORDER BY year DESC

--7. Which genre has the most games in the dataset?

SELECT 
genre,
COUNT(*) AS game_count
FROM video_game_sales
GROUP BY genre
ORDER BY game_count DESC


--8. What is the percentage of total global sales for each platform?

SELECT platform, 
       SUM(global_sales) AS total_sales, 
       SUM(global_sales) * 100.0 / SUM(SUM(global_sales)) OVER () AS per_sales
FROM video_game_sales
GROUP BY platform
ORDER BY total_sales DESC;


--9. Find the game with the highest sales in North America for each year.

SELECT DISTINCT
year,
name,
na_sales
FROM video_game_sales
WHERE year IS NOT null
ORDER BY year DESC, na_sales DESC


--10. Which game had the highest combined sales in Europe and Japan?

SELECT 
name,
eu_sales,
jp_sales,
(eu_sales + jp_sales) AS eu_jp_sales
FROM video_game_sales
ORDER BY eu_jp_sales DESC
LIMIT 5
