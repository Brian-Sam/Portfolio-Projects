--SELECT location, date, population, new_cases, total_deaths,
--FROM`seventh-project-320915.Covid.COVID_deaths`
--ORDER BY  1,2

--try to find the total cases to deaths ratio
SELECT
    location, 
    date,
    population,
    total_cases,
    total_deaths,
    (total_deaths/total_cases)*100 as death_ratio
FROM
    `seventh-project-320915.Covid.COVID_deaths`
WHERE
    location="Afghanistan" AND total_cases IS NOT NULL
ORDER BY
    1,2
--This shows as of 2021-08-25, the death rate in Afghanistan is 4.64%
--we can also change this to show the death rate in the united states as well, which would be 1.65%
--you can change this code to show whichever country is within the dataset, 
SELECT
    location, 
    date,
    population,
    total_cases,
    total_deaths,
    (total_deaths/total_cases)*100 as death_percent
FROM
    `seventh-project-320915.Covid.COVID_deaths`
WHERE
    location="United States" AND total_cases IS NOT NULL
ORDER BY
    1,2

--Total cases to population ratio 
SELECT
    location,
    date,
    population,
    total_cases,
    (total_cases/population)*100 as covid_percent
FROM
    `seventh-project-320915.Covid.COVID_deaths`
WHERE
    location="United States"
order by 
    location, 
    date
-- Countries with Highest Infection Rate compared to Population
SELECT
    location,
    population,
    MAX((total_cases/population)*100) as highest_infection_rate
FROM
    `seventh-project-320915.Covid.COVID_deaths`
GROUP BY
    location, --why do you need this?
    population
ORDER BY 
    highest_infection_rate DESC,
    1,
    2 
--highest amount of deaths from the virus?
SELECT
    location,
    population,
    MAX(total_deaths) as highest_deaths
FROM
    `seventh-project-320915.Covid.COVID_deaths`
WHERE
    continent IS NOT NULL
GROUP BY
    location,
    population
ORDER BY
    highest_deaths DESC
--highest amount of death per population from Virus 
SELECT
    location,
    population,
    MAX((total_deaths/population)*100) as death_ratio
FROM
    `seventh-project-320915.Covid.COVID_deaths`
WHERE
    continent IS NOT NULL
GROUP BY
    location,
    population 
ORDER BY
    death_ratio DESC

--showing continents with highest death count 
SELECT 
    location,
    MAX(total_deaths) as highest_deaths
FROM
    `seventh-project-320915.Covid.COVID_deaths`
WHERE
    continent IS NULL
GROUP BY
    location
ORDER BY
    highest_deaths DESC

--continents with highest death count per population
SELECT
    continent,
    location,
    population,
    MAX((total_deaths/population)*100) as highest_deaths,
FROM 
    `seventh-project-320915.Covid.COVID_deaths`
WHERE
    continent IS NOT NULL 
GROUP BY 
    continent,location, population
ORDER BY
    highest_deaths DESC 

--global numbers
SELECT--why does this work?
    date,
    SUM(new_cases) as totalcases,
    SUM(new_deaths) as totaldeaths,
    (SUM(new_deaths)/SUM(new_cases))*100 as deathpercentage
FROM
    `seventh-project-320915.Covid.COVID_deaths`
WHERE
    continent IS NOT NULL
GROUP BY
    date
ORDER BY 
    date,
    totalcases

--total population vs vaccinations
--percentage of people who have recieved vaccinations
SELECT
    deaths.location,
    deaths.date,
    deaths.population,
    vacs.new_vaccinations,
    SUM(vacs.new_vaccinations) OVER (partition by deaths.location ORDER BY deaths.location, deaths.date) as people_vaccinated
FROM
    `seventh-project-320915.Covid.COVID_deaths` as deaths 
JOIN 
    `seventh-project-320915.Covid.COVID_vaccinations` as vacs
ON deaths.location=vacs.location AND deaths.date=vacs.date
WHERE
    deaths.continent IS NOT NULL
ORDER BY
1,2

--temp table to calculate percentage of vaccinations 
WITH population_vaccinated  as 
(SELECT
    deaths.location,
    deaths.continent,
    deaths.date,
    deaths.population,
    vacs.new_vaccinations,
    SUM(vacs.new_vaccinations) OVER (partition by deaths.location ORDER BY deaths.location, deaths.date) as people_vaccinated
FROM
    `seventh-project-320915.Covid.COVID_deaths` as deaths 
JOIN 
    `seventh-project-320915.Covid.COVID_vaccinations` as vacs
ON deaths.location=vacs.location AND deaths.date=vacs.date
WHERE
    deaths.continent IS NOT NULL)

SELECT
    *,
    (people_vaccinated/population)*100 as percentvaccinated 
FROM
    population_vaccinated 
ORDER BY
location

--what if I wanted the highest number of vaccinations per country?

WITH population_vaccinated  as 
(SELECT
    deaths.location,
    deaths.continent,
    deaths.date,
    deaths.population,
    vacs.new_vaccinations,
    SUM(vacs.new_vaccinations) OVER (partition by deaths.location ORDER BY deaths.location, deaths.date) as people_vaccinated
FROM
    `seventh-project-320915.Covid.COVID_deaths` as deaths 
JOIN 
    `seventh-project-320915.Covid.COVID_vaccinations` as vacs
ON deaths.location=vacs.location AND deaths.date=vacs.date
WHERE
    deaths.continent IS NOT NULL)

SELECT DISTINCT 
    location,
    continent,
    population,
    MAX(people_vaccinated) OVER (partition by location) as highestvacs,
FROM
    population_vaccinated 
WHERE
    new_vaccinations IS NOT NULL 
ORDER BY
    location

