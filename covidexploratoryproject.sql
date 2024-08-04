SELECT *
FROM covid.coviddeaths
WHERE continent is not null
ORDER BY 3, 4;

SELECT *
FROM covid.covidvaccinations
ORDER BY 3, 4;

-- select data we are going to use

SELECT Location, Date, total_cases, new_cases, total_deaths, population
FROM coviddeaths
WHERE continent is not null
ORDER BY 1,2;

-- looking at total cases vs total deaths

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM coviddeaths
WHERE location like '%india%'
and continent is not null
ORDER BY 1,2;

-- looking at total case vs population

SELECT Location, date, population, total_cases, (total_cases/population)*100 as PopulationInfected
FROM coviddeaths
WHERE location like '%india%'
AND continent is not null
ORDER BY 1,2;

-- looking at countries with highest infection rate to population

SELECT Location, population, MAX(total_cases) as Highestinfectioncount, 
	MAX((total_cases/population))*100 as PopulationInfected
FROM coviddeaths
-- WHERE location like '%india%'
WHERE continent is not null
GROUP BY Location, population
ORDER BY PopulationInfected DESC;

-- showing countries with highest death count per population

SELECT continent, MAX(total_deaths) AS Totaldeathcount
FROM coviddeaths
-- WHERE location like '%india%'
WHERE continent is not null
GROUP BY continent
ORDER BY Totaldeathcount DESC;

SELECT location, MAX(total_deaths) AS Totaldeathcount
FROM coviddeaths
-- WHERE location like '%india%'
WHERE continent is not null
GROUP BY location
ORDER BY Totaldeathcount DESC;

  -- showing continents with highest death count per population
  
SELECT continent, MAX(total_deaths) AS Totaldeathcount
FROM coviddeaths
-- WHERE location like '%india%'
WHERE continent is not null
GROUP BY continent
ORDER BY Totaldeathcount DESC;

-- global numbers

SELECT date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(new_cases)*100 AS deathpercent
FROM coviddeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2;

SELECT *
FROM coviddeaths dea
JOIN covidvaccinations vac
ON dea.location = vac.location
and dea.date = vac.date;

-- looking at total population vs vaccination

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM coviddeaths dea
JOIN covidvaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3;

-- create some views

CREATE VIEW PopvsVac as 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM coviddeaths dea
JOIN covidvaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3;

CREATE VIEW Globalnumbers as
SELECT date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(new_cases)*100 AS deathpercent
FROM coviddeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2;

CREATE VIEW casevspop as
SELECT Location, date, population, total_cases, (total_cases/population)*100 as PopulationInfected
FROM coviddeaths
WHERE location like '%india%'
AND continent is not null
ORDER BY 1,2;