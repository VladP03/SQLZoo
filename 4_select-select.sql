-- link: https://sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial

-- 1.
SELECT name FROM world
  WHERE population > (SELECT population FROM world WHERE name='Russia');

-- 2.
SELECT name FROM world
 WHERE gdp/population > (SELECT gdp/population FROM world WHERE name ='United Kingdom') AND continent = 'Europe';

-- 3.
SELECT name, continent FROM world
 WHERE continent = (SELECT continent FROM world WHERE name='Argentina') OR continent = (SELECT continent FROM world WHERE name='Australia')
  ORDER BY name;

-- 4.
SELECT name FROM world
 WHERE population BETWEEN (SELECT population FROM world WHERE name='Poland') AND (SELECT population FROM world WHERE name='Canada');

-- 5.
SELECT name "Name", CONCAT(ROUND((100*population/(SELECT population FROM world WHERE name='Germany'))),'%') "percentage" FROM world
 WHERE continent='Europe';

-- 6.
SELECT name FROM world
 WHERE gdp > (SELECT max(GDP) FROM world WHERE continent='Europe');

-- 7.
SELECT continent, name, area FROM world x
  WHERE area>= ALL (SELECT area FROM world y WHERE y.continent=x.continent AND area>0);

-- 8.
SELECT continent, name FROM world x
 WHERE name <= ALL(SELECT name FROM world y WHERE x.continent = y.continent);

-- 9.
SELECT name, continent, population FROM world x
 WHERE 25000000 >= ALL(SELECT population FROM world y WHERE x.continent = y.continent);

-- 10. v1
SELECT name, continent FROM world x
 WHERE population > (SELECT 3*MAX(population) FROM world y WHERE x.continent = y.continent AND x.name != y.name);

-- 10. v2
SELECT name, continent FROM world x
 WHERE population > ALL(SELECT 3*population FROM world y WHERE x.continent = y.continent AND x.name != y.name);
