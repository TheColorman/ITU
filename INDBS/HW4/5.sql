-- (a)
SELECT * FROM songs
WHERE
    songs.duration >= INTERVAL '30 minutes' AND
    songs.duration <= INTERVAL '1 hour';
-- 6 songs

-- (b)
SELECT sum(extract(epoch from duration)) FROM songs
WHERE songs.isexplicit = 1;
-- 100461 seconds

-- (c)
SELECT count(*), extract(year from releaseDate) AS year FROM songs
GROUP BY extract(year from releaseDate)
ORDER BY count DESC
LIMIT 1;
-- 833 songs released in 2009

-- (d)
SELECT ROUND(MAX(mins)) FROM (
    SELECT AVG(extract(epoch from duration)) mins FROM albumartists aa
    JOIN artists a ON a.artistid = aa.artistid
    JOIN albumsongs sa ON sa.albumid = aa.albumid
    JOIN songs s ON s.songid = sa.songid
    WHERE a.artist = 'Daft Punk'
    GROUP BY aa.albumid
);
-- 370 minutes

-- (e)
SELECT COUNT(DISTINCT albumid) FROM albumgenres ag
JOIN genres g ON ag.genreid = g.genreid
WHERE g.genre LIKE 'Sou%';
-- 14 albums

-- (f)
SELECT COUNT(*) FROM (
    SELECT COUNT(s.title) songs FROM songs s
    GROUP BY s.title
) WHERE songs > 1;
-- 938 songs with duplicate titles

-- (g)
SELECT AVG(genrecount) FROM (
    SELECT COUNT(genreid) genrecount FROM albumgenres
    GROUP BY albumid
);
-- 1.1994069681245367 genres per album

-- (h)
SELECT 
    (SELECT COUNT(*) FROM albums) - COUNT(DISTINCT albumid) 
FROM albumgenres ag
JOIN genres g ON g.genreid = ag.genreid
WHERE genre = 'Jazz';
-- 1248 albums.