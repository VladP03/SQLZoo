-- link: https://sqlzoo.net/wiki/More_JOIN_operations

-- 1.
SELECT id, title FROM movie
 WHERE yr=1962l;

-- 2.
SELECT yr FROM movie
 WHERE title='Citizen Kane';

-- 3.
SELECT id, title, yr FROM movie
 WHERE title LIKE '%Star Trek%'
  ORDER BY yr;

-- 4.
SELECT id FROM actor
 WHERE name ='Glenn Close';

-- 5.
SELECT id FROM movie
 WHERE title='Casablanca';

-- 6.
SELECT name FROM actor
 JOIN casting ON (actor.id = casting.actorid)
 JOIN movie ON (casting.movieid = movie.id)
  WHERE title = 'Casablanca';

-- 7.
SELECT name FROM actor
 JOIN casting ON (actor.id = casting.actorid)
 JOIN movie ON (casting.movieid = movie.id)
  WHERE title = 'Alien';

-- 8.
SELECT title FROM movie
 JOIN casting ON (movie.id = casting.movieid)
 JOIN actor ON (casting.actorid = actor.id)
  WHERE actor.name = 'Harrison Ford';

-- 9.
SELECT title FROM movie
 JOIN casting ON (movie.id = casting.movieid)
 JOIN actor ON (casting.actorid = actor.id)
  WHERE actor.name = 'Harrison Ford' AND casting.ord >1;

-- 10.
SELECT title, name FROM movie
 JOIN casting ON (movie.id = casting.movieid)
 JOIN actor ON (casting.actorid = actor.id)
  WHERE yr = 1962 AND ord = 1;

-- 11.
SELECT yr, COUNT(title) FROM movie
 JOIN casting ON (casting.movieid = movie.id)
 JOIN actor ON (casting.actorid = actor.id)
  WHERE name = 'Rock Hudson'
   GROUP BY yr
    HAVING COUNT(yr) > 2;

-- 12.
SELECT title, name FROM movie
 JOIN casting ON (movie.id = casting.movieid AND ord=1)
 JOIN actor ON (casting.actorid = actor.id)
  WHERE movie.id IN (SELECT movieid FROM casting
                      WHERE actorid IN ( SELECT id FROM actor WHERE name='Julie Andrews'));

-- 13.
SELECT name FROM actor 
 JOIN casting ON (actor.id = casting.actorid)
  WHERE ord = 1
   GROUP BY name
    HAVING count(name)>=15;

-- 14.
SELECT title, COUNT(actor.id) FROM movie
 JOIN casting ON (movie.id = casting.movieid)
 JOIN actor ON (actor.id = casting.actorid)
  WHERE yr=1978
   GROUP BY title
    ORDER BY COUNT(actor.id) desc, title;

-- 15.
SELECT DISTINCT(name) FROM actor
 JOIN casting ON (actor.id = casting.actorid)
 JOIN movie ON (casting.movieid = movie.id)
  WHERE title IN (SELECT title FROM movie
                   JOIN casting ON (casting.movieid = movie.id)
                   JOIN actor ON (casting.actorid = actor.id)
                    WHERE name='Art Garfunkel')
  AND name!='Art Garfunkel';
