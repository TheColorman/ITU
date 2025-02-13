-- (1) The person relation contains 4 entries with a registered death date on ‘2010-03-17’. How many entries do not have a registered death date?
SELECT COUNT(*) FROM person
WHERE deathdate IS NULL;

-- (2) In the database, there are 279 movies in the French language for which the average height of all the people involved is greater than 175 centimeters (ignoring people with unregistered height). What is the number of movies in the French language for which the average height of all people involved is greater than 185 centimeters?
SELECT COUNT(*) FROM (
    SELECT movie.title, AVG(person.height) FROM movie
    JOIN involved ON movie.id = involved.movieid
    JOIN person ON involved.personid = person.id
    WHERE movie.language = 'French'
    GROUP BY movie.id
    HAVING AVG(person.height) > 185
) AS tmp;

-- (3) The movie genre relation does not have a primary key, which can lead to a movie having more than one entry with the same genre. As a result, there are 3 movies in movie genre that have the genre ‘Crime’ assigned to them more than once. How many movies in movie genre have the genre ‘Action’ assigned to them more than once?
SELECT COUNT(*) FROM (
    SELECT movieid, COUNT(genre) FROM movie_genre
    WHERE genre = 'Action'
    GROUP BY movieid
    HAVING COUNT(genre) > 1
) AS tmp;

-- (4) According to the information in the database, 7689 different people acted in movies directed by ‘Quentin Tarantino’. How many different people acted in movies directed by ‘Ingmar Bergman’?
SELECT COUNT(DISTINCT I2.personid) FROM (
    SELECT DISTINCT movieid 
    FROM involved I1
    JOIN person P ON P.id = I1.personid
    WHERE P.name = 'Ingmar Bergman'
    AND I1.role = 'director'
) AS guy_movies
JOIN involved I2 ON guy_movies.movieid = I2.movieid
AND I2.role = 'actor';


-- (5) Of all the movies produced in 2002, there are 11 that have only one actor involved in them. How many movies produced in 2010 have only one actor involved in them?
SELECT COUNT(*) FROM (
    SELECT movieid FROM involved
    JOIN movie ON movie.id = involved.movieid
    WHERE 
        involved.role = 'actor'
        AND movie.year = 2010
    GROUP BY movieid
    HAVING COUNT(personid) = 1
) tmp;

--- (6) In the database, there are 16 cases where a specific actor and director have collaborated together on 12 movies. How many are the cases where a specific actor and director collaborated together in more than 12 movies?
SELECT COUNT(*) FROM (
    SELECT I1.personid
    FROM involved I1
    JOIN involved I2 ON
        I1.movieid = I2.movieid
    WHERE 
        I1.role = 'actor'
        AND I2.role = 'director'
        AND I1.personid != I2.personid
    GROUP BY I1.personid, I2.personid
    HAVING COUNT(*) > 12
) tmp;

-- (7) Of all the movies produced in 2010, there are 237 that have entries registered in involved for all roles defined in the roles relation. How many movies produced in 2000 have entries registered in involved for all roles defined in the roles relation? Note: This is a relational division query that must work for any instance; Do not use any ‘magic numbers’.
SELECT COUNT(*) FROM (
    SELECT movieid FROM involved
    JOIN movie ON movie.id = movieid
    WHERE year = 2000
    GROUP BY movieid
    HAVING COUNT(DISTINCT involved.role) = (
        SELECT COUNT(*) FROM role
    )
) tmp;

-- (8) The number of people who have played a role in movies of all genres in the category ‘Misc’ is 543. How many people have played a role in movies of all genres in the category ‘Popular’?
SELECT COUNT(*) FROM (
    SELECT personid FROM involved
        JOIN movie_genre ON movie_genre.movieid = involved.movieid
        JOIN genre ON genre.genre = movie_genre.genre
    WHERE category = 'Popular' -- I don't like that I'm filter by cat twice, but not sure how to improve this
    GROUP BY personid
    HAVING COUNT(DISTINCT movie_genre.genre) = (
        SELECT COUNT(DISTINCT genre) FROM genre
        WHERE category = 'Popular'
    )
) tmp;