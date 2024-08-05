

## About Dataset
This dataset contains a list of video games with sales greater than 100,000 copies. It was generated by a scrape of vgchartz.com.

Fields include:

- Rank : Ranking of overall sales
- Name : The games name
- Platform : Platform of the games release (i.e. PC,PS4, etc.)
- Year : Year of the game's release
- Genre : Genre of the game
- Publisher : Publisher of the game
- NA_Sales : Sales in North America (in millions)
- EU_Sales : Sales in Europe (in millions)
- JP_Sales : Sales in Japan (in millions)
- Other_Sales : Sales in the rest of the world (in millions)
- Global_Sales : Total worldwide sales.


<br><br>
To execute this SQL statement in pgAdmin:

- Open pgAdmin and connect to your database.
- Right-click on your database and select Query Tool.
- Copy and paste the SQL statement into the query window.
 ```sql
CREATE TABLE video_game_sales (
    rank INT,
    name VARCHAR(255),
    platform VARCHAR(50),
    year INT,
    genre VARCHAR(50),
    publisher VARCHAR(100),
    na_sales FLOAT,
    eu_sales FLOAT,
    jp_sales FLOAT,
    other_sales FLOAT,
    global_sales FLOAT
);
```
- Click the Execute button (or press F5) to run the query and create the table.
- Import `video_game_sales.cv` 


<br><br>
 Here are some example questions that you can use for data analysis with your `video_game_sales` table in PostgreSQL.

 1. What are the top 10 games by global sales?
```sql
SELECT
name, 
global_sales
FROM video_game_sales
ORDER BY global_sales DESC
LIMIT 10
```


2. Which platform has the most games in the top 100 global sales?
```sql
SELECT 
platform, 
COUNT(*) AS game_count,
SUM(global_sales) AS total_sales
FROM video_game_sales
GROUP BY platform
ORDER BY total_sales DESC, game_count DESC
LIMIT 100
```


3. What are the total sales in North America, Europe, Japan, and other regions?
```sql
SELECT 
SUM(na_sales) AS na_total_sales,
SUM(eu_sales) AS eu_total_sales,
SUM(jp_sales) AS jp_total_sales,
SUM(other_sales) AS other_total_sales
FROM video_game_sales
```

4. What is the average global sales per genre?
```sql
SELECT 
genre,
ROUND(AVG(global_sales)::numeric,2) AS average_global_sales
FROM video_game_sales
GROUP BY  genre 
ORDER BY average_global_sales DESC
```


5. Which publisher has the highest average global sales per game?
```sql
SELECT 
publisher, 
ROUND(AVG(global_sales)::numeric,2) AS average_global_sales
FROM video_game_sales
GROUP BY publisher
ORDER BY average_global_sales DESC
LIMIT 10
```


6. What are the total sales by year?
```sql
SELECT
year,
SUM(global_sales) AS total_sales
FROM video_game_sales
GROUP BY year
ORDER BY year DESC
```


7. Which genre has the most games in the dataset?
```sql
SELECT 
genre,
COUNT(*) AS game_count
FROM video_game_sales
GROUP BY genre
ORDER BY game_count DESC
```


8. What is the percentage of total global sales for each platform?
```sql
SELECT platform, 
       SUM(global_sales) AS total_sales, 
       SUM(global_sales) * 100.0 / SUM(SUM(global_sales)) OVER () AS per_sales
FROM video_game_sales
GROUP BY platform
ORDER BY total_sales DESC;
```


9. Find the game with the highest sales in North America for each year.
```sql
SELECT DISTINCT
year,
name,
na_sales
FROM video_game_sales
WHERE year IS NOT null
ORDER BY year DESC, na_sales DESC
```

10. Which game had the highest combined sales in Europe and Japan?
```sql
SELECT 
name,
eu_sales,
jp_sales,
(eu_sales + jp_sales) AS eu_jp_sales
FROM video_game_sales
ORDER BY eu_jp_sales DESC
LIMIT 5
```

<br><br>
## Tableau Video Game Sales Dashboard Link:
https://public.tableau.com/app/profile/bilge.akar/viz/Book1_17228780802550/Video_game_sale_dashboard


![Video_game_sale_dashboard](https://github.com/user-attachments/assets/e966ab99-0a96-4788-b34d-b112528fe3b1)
