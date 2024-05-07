SELECT * 
FROM CovidDeaths
ORDER BY 3,4

-- SELECT * FROM CovidVaccinations ORDER BY 3,4

-- SELECT DATA THAT WE ARE GOING TO BE USING

SELECT location, date,total_cases, new_cases, total_cases, population
FROM CovidDeaths
ORDER BY 1,2

-- LOOKING AT TOTAL CASES VS TOTAL DEATHS
-- SHOWS LIKELIHOOD OF DYING IF YOU CONTRACT COVID IN YOUR COUNTRY

SELECT location, date,total_cases, total_deaths, 
    CASE 
        WHEN ISNUMERIC(total_deaths) = 1 AND ISNUMERIC(total_cases) = 1 AND total_cases <> 0 THEN 
            (CONVERT(float, total_deaths) / CONVERT(float, total_cases)) * 100 
        ELSE 
            NULL 
    END AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location LIKE '%states%' AND continent is not null
ORDER BY 1, 2;


-- LOOKING AT TOTAL CASES VS POPULATION
-- SHOWS WHAT PERCENTAGE OF POPULATION GOT COVID

SELECT location, date, population, total_cases , (total_cases/population)*100 AS PercentPopulationInfection
FROM CovidDeaths
WHERE location LIKE '%viet%'
ORDER BY 1,2

-- LOOKING AT COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION
SELECT location, population, MAX(total_cases) AS HighestInfectionCount , MAX((total_cases/population))*100 AS PercentPopulationInfection
FROM CovidDeaths
GROUP BY location, population
ORDER BY PercentPopulationInfection DESC


-- SHOWING COUNTRIES WITH HIGHEST DEATH COUNT PER POPULATION

SELECT location, MAX(cast(total_deaths AS INT)) AS TotalDeathCount 
FROM CovidDeaths
WHERE continent is not null 
GROUP BY location
ORDER BY TotalDeathCount DESC


-- LET'S BREAK THINGS DOWN BY CONTINENT
-- SHOWING CONTINTENTS WITH THE HIGHEST DEATH COUNT PER POPULATION

SELECT continent, MAX(cast(total_deaths AS INT)) AS TotalDeathCount 
FROM CovidDeaths
WHERE continent is not null 
GROUP BY continent
ORDER BY TotalDeathCount DESC


-- GLOBAL NUMBERS
SELECT SUM(new_cases) AS Total_Cases, SUM(cast(new_deaths AS INT)) AS Total_Deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS DeathsPercentage	
FROM CovidDeaths
WHERE continent is not null 
ORDER BY 1,2




SELECT * 
FROM CovidVaccinations
