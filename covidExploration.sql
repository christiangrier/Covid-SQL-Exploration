# Total Cases vs Total Deaths
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentages
From coviddeaths
Where location Like '%states%'
order by date;

# Total Cases vs Population
Select location, date, total_cases, population, (total_cases/population)*100 as contraction_percentages
From coviddeaths
Where location Like '%states%'
order by date;

# Total Deaths vs Population
Select location, date, total_deaths, population, (total_deaths/population)*100 as death_percentages
From coviddeaths
Where location Like '%states%'
order by date;

# High Infection rate vs Population
Select location, date, max(total_cases) as highest_infection, population, max((total_cases/population))*100 as infection_percentages
From coviddeaths
#where population >= 1000000
group by location, population
order by infection_percentages desc;

# Countries with Highest Death Count per Population
select location, max(total_deaths) as total_death_count
From coviddeaths
where continent is not null
group by location
order by total_death_count desc;

# Continents with Highest Death Count per Population
select continent, max(total_deaths) as total_death_count
From coviddeaths
where continent != '0'
group by continent
order by total_death_count desc;

# Looking at the number of people vaccinated to the population based in each location(country)
Select d.continent, d.location, d.date, d.population, v.new_vaccinations, sum(v.new_vaccinations) over (partition by d.location order by d.location, d.date) as people_vaccinated, (people_vaccinated/d.population)*100 as percentage_of_vaccinated_people
from coviddeaths d
join covidvaccinations v
	on d.location = v.location 
    and d.date = v.date
where d.continent != '0' # and d.location like '%states'
order by d.date;

# Looking at the number of new and total cases in Australia as they are currently experience a spike
Select location, date, new_cases, total_cases
From coviddeaths
Where location Like 'Australia'
order by date;