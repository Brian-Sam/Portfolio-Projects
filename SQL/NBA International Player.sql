--NBA Players dataset by Justinas Cirtautas was found through Kaggle

--shows the amount of international players in the nba up until 2020 (1864)
SELECT DISTINCT 
    *
FROM 
    `third-project-318619.nba.nba_seasons`
WHERE
    country<>"USA" 
ORDER BY
    season
--This shows players that averaged 20 or more points that were international players (24)
--see that more and more international players are averaging 20 or more in recent years
SELECT DISTINCT 
    player_name,country,pts,season
FROM 
    `third-project-318619.nba.nba_seasons`
WHERE
    country<>"USA" AND pts>= 20
GROUP BY
    player_name,country,pts,season
ORDER BY 
    season
--when did the most international players get drafted
SELECT  
    draft_year, COUNT(country)
FROM 
    `third-project-318619.nba.nba_seasons`
WHERE
    country<>"USA" AND draft_round <>"Undrafted"
GROUP BY
    draft_year
ORDER BY
   draft_year
--percent of international players in the league 
--total 374 international players
--France, Canada, Australia, Spain, Brazil are the highest according to this dataset
SELECT
  country,count(country)
FROM
    `third-project-318619.nba.nba_seasons`
WHERE
    country <> "USA"
GROUP BY 
country
order by
  count(country) DESC

--how many international players are averaging 20 or more pts in the contemporary nba(past 5 years)?
--shows that there have been 35 times where international players have averaged 20 or more pts, most of these players go on to fill out positions in all star games

WITH rev_season as

(SELECT
    player_name,
    country,
    pts,
    split(season,"-") as new_season,
FROM 
    `third-project-318619.nba.nba_seasons`)

SELECT
    player_name,
    country,
    pts,
    CAST(new_season AS INT64)
FROM
    rev_season 
HAVING     
    country <> "USA" AND pts>20 AND new_season>2015
