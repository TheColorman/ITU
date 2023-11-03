-- 1. The name and record of all sports sorted by name. 
SELECT name, record from sports ORDER BY name;

-- 2. The name of all sports with at least one result.
INSERT INTO Sports (id, name)
VALUES (10, 'Fake Sport')
ON CONFLICT DO NOTHING;
SELECT name FROM sports 
WHERE (
    SELECT COUNT(*) FROM results 
    WHERE results.sportid = sports.id
) > 0;

-- 3. The number of athletes who have competed in at least one sport.
SELECT COUNT(DISTINCT peopleid) FROM results;

-- 4. The ID and name of athletes who have at least twenty results.
SELECT peopleid, people.name FROM results
JOIN people ON results.peopleid = people.id
GROUP BY peopleid, people.name
HAVING COUNT(*) >= 20;

-- 5. The ID, name and gender description of all athletes that currently hold a record.
SELECT DISTINCT peopleid, people.name, gender.description FROM sports
JOIN results ON 
    sports.record = results.result AND sports.id = results.sportid
JOIN people ON
    people.id = results.peopleid
JOIN gender ON
    gender.gender = people.gender;

-- 6. For each sport, where some athlete holds the record, the name of the sport and the number of athletes that hold a record in that sport; the last column should be named “numathletes”.
SELECT sports.name, COUNT(DISTINCT peopleid) AS numathletes FROM results
JOIN sports ON
    results.result = sports.record AND results.sportid = sports.id
GROUP BY sportid, sports.name;

-- 7. The ID and name of each athlete that has at least twenty results in the triple jump, their best result, along with the difference between the record and their best result. The second-to-last column should be named “best” while the last column should be named “difference”. The last column should always contain non-negative values and should preferably be formatted to show at least one digit before the decimal point and exactly two digits after the decimal point.
SELECT 
    peopleid, 
    people.name, 
    MAX(result) AS best, 
    ROUND(CAST(sports.record - MAX(result) AS numeric), 2) AS difference
FROM results
JOIN sports ON
    sports.id = results.sportid
JOIN people ON
    people.id = results.peopleid
WHERE sports.name='Triple Jump'
GROUP BY peopleid, people.name, sports.record
HAVING COUNT(*) >= 20;

-- 8. The ID, name and gender description of all athletes who participated in the competition held in Hvide Sande in 2009.
SELECT DISTINCT peopleid, people.name, gender.description FROM results
JOIN competitions ON
    competitions.id = competitionid
JOIN people ON
    people.id = results.peopleid
JOIN gender ON
    gender.gender = people.gender
WHERE 
    place = 'Hvide Sande' AND EXTRACT('Year' FROM held) = 2009;

-- 9. The name and gender description of all people with a last name that starts with a “J” and ends with a “sen” (e.g., Jensen, Jansen, Johansen).
SELECT people.name, gender.description FROM people
JOIN gender ON
    gender.gender = people.gender
WHERE people.name LIKE '% J%sen';

-- 10. For each result, the name of the athlete, the name of the sport, and the percentage of the record achieved by the result (a result that is a record should therefore appear as 100; this column should be named “percentage”). Preferably, format the last column to show only whole numbers, as well as the % sign, you can use CASE to detect when the result is NULL and when not.
SELECT
    people.name,
    sports.name,
    CAST(
        ROUND((results.result / sports.record) * 100) AS VARCHAR
    ) || '%' AS percentage
FROM results
JOIN people ON
    people.id = results.peopleid
JOIN sports ON
    sports.id = results.sportid;

-- 11. The number of athletes with some incomplete result registrations.
SELECT COUNT(DISTINCT peopleid) FROM results
JOIN people ON
    people.id = results.peopleid
WHERE
    result IS NULL OR
    competitionid IS NULL OR
    sportid IS NULL;

-- 12. For each sport, show the ID and name of the sport and the best performance over all athletes and competitions. This last column should be called ‘maxres’ and should be formatted to show at least one digit before the decimal point and exactly two digits after the decimal point. The query result should be ordered by the sport ID.
SELECT
    sports.id,
    sports.name,
    ROUND(
        CAST(MAX(result) AS NUMERIC),
        2
    ) AS maxres
FROM sports
JOIN results ON
    results.sportid = sports.id
GROUP BY sports.id
ORDER BY sports.id;

-- 13.Show the ID and name of athletes who hold a record in at least two sports, along with the total number of their record-setting or record-equaling results. 
SELECT people.id, people.name, COUNT(sports.id) FROM sports
JOIN results ON
    results.sportid = sports.id AND results.result = sports.record
JOIN people ON
    people.id = results.peopleid
GROUP BY people.id
HAVING COUNT(DISTINCT sports.id) >= 2;

-- 14.Show the ID, name, and height of athletes who have achieved the best result in each sport, along with the result, the name of the sport, and a column called ‘record?’ which contains 1 if the result is a record or 0 if the result is not a record. Note that for each sport there may be many athletes who share the best result, in this case all the rows should be in the result. If you can print ‘yes’ and ‘no’ instead of 1 and 0, all the better.
SELECT
    people.id,
    people.name,
    people.height,
    results.result,
    sports.name,
    CASE
        WHEN result = sports.record
        THEN 'yes'
        ELSE 'no'
    END "record?"
FROM sports
JOIN results ON
    results.sportid = sports.id
JOIN people ON
    people.id = results.peopleid
WHERE (
    SELECT MAX(result) 
    FROM results 
    WHERE results.sportid = sports.id
) = result;