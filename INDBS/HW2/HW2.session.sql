-- (a) The empire ‘Danish Empire’ consists of 3 countries. How many countries does the empire ‘Great Britain’ consist of?  
SELECT COUNT(*) FROM empires
WHERE empire = 'Great Britain';
-- Answer: 4

-- (b) There are 4 countries that are present on more than one continent. How many of these countries are partially in Asia?  
-- I overcomplicated the hell out of this one when I could just have done this lol
SELECT * FROM countries_continents
WHERE
    percentage < 100.0
    AND continent = 'Asia';
-- Answer: 4

-- (c) In the countries of North America that have more than 10 million inhabitants, there are a total of 130,731,300 people who speak Spanish, according to the statistics in the database. What is the corresponding number for Europe?  
SELECT SUM((CL.percentage * C.population) / 100) FROM countries_continents CC
JOIN countries_languages CL ON CL.countrycode = CC.countrycode
JOIN countries C ON C.code = CC.countrycode
WHERE
    continent = 'Europe'
    AND language = 'Spanish'
    AND population > 10^7;
-- Answer: 29581527.6, rounds up to 29581528

-- (d) According to the database, two languages are spoken in all countries of ‘Benelux’. How many languages are spoken in all countries of ‘Great Britain’?  
SELECT COUNT(*) FROM (
    SELECT language FROM empires E
    JOIN countries_languages CL ON CL.countrycode = E.countrycode
    WHERE empire = 'Great Britain'
    GROUP BY language
    HAVING COUNT(E.countrycode) = (
        SELECT COUNT(E2.countrycode) FROM empires E2
        WHERE empire = 'Great Britain'
    )
) TMP
-- Answer: 1