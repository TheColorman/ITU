
SELECT 'Rentals: pid --> hid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pid
        FROM Rentals R
        GROUP BY R.pid
        HAVING COUNT(DISTINCT R.hid) > 1
) X;


SELECT 'Rentals: pid --> pn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pid
        FROM Rentals R
        GROUP BY R.pid
        HAVING COUNT(DISTINCT R.pn) > 1
) X;


SELECT 'Rentals: pid --> s' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pid
        FROM Rentals R
        GROUP BY R.pid
        HAVING COUNT(DISTINCT R.s) > 1
) X;


SELECT 'Rentals: pid --> hs' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pid
        FROM Rentals R
        GROUP BY R.pid
        HAVING COUNT(DISTINCT R.hs) > 1
) X;


SELECT 'Rentals: pid --> hz' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pid
        FROM Rentals R
        GROUP BY R.pid
        HAVING COUNT(DISTINCT R.hz) > 1
) X;


SELECT 'Rentals: pid --> hc' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pid
        FROM Rentals R
        GROUP BY R.pid
        HAVING COUNT(DISTINCT R.hc) > 1
) X;


SELECT 'Rentals: hid --> pid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hid
        FROM Rentals R
        GROUP BY R.hid
        HAVING COUNT(DISTINCT R.pid) > 1
) X;


SELECT 'Rentals: hid --> pn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hid
        FROM Rentals R
        GROUP BY R.hid
        HAVING COUNT(DISTINCT R.pn) > 1
) X;


SELECT 'Rentals: hid --> s' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hid
        FROM Rentals R
        GROUP BY R.hid
        HAVING COUNT(DISTINCT R.s) > 1
) X;


SELECT 'Rentals: hid --> hs' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hid
        FROM Rentals R
        GROUP BY R.hid
        HAVING COUNT(DISTINCT R.hs) > 1
) X;


SELECT 'Rentals: hid --> hz' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hid
        FROM Rentals R
        GROUP BY R.hid
        HAVING COUNT(DISTINCT R.hz) > 1
) X;


SELECT 'Rentals: hid --> hc' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hid
        FROM Rentals R
        GROUP BY R.hid
        HAVING COUNT(DISTINCT R.hc) > 1
) X;


SELECT 'Rentals: pn --> pid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pn
        FROM Rentals R
        GROUP BY R.pn
        HAVING COUNT(DISTINCT R.pid) > 1
) X;


SELECT 'Rentals: pn --> hid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pn
        FROM Rentals R
        GROUP BY R.pn
        HAVING COUNT(DISTINCT R.hid) > 1
) X;


SELECT 'Rentals: pn --> s' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pn
        FROM Rentals R
        GROUP BY R.pn
        HAVING COUNT(DISTINCT R.s) > 1
) X;


SELECT 'Rentals: pn --> hs' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pn
        FROM Rentals R
        GROUP BY R.pn
        HAVING COUNT(DISTINCT R.hs) > 1
) X;


SELECT 'Rentals: pn --> hz' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pn
        FROM Rentals R
        GROUP BY R.pn
        HAVING COUNT(DISTINCT R.hz) > 1
) X;


SELECT 'Rentals: pn --> hc' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pn
        FROM Rentals R
        GROUP BY R.pn
        HAVING COUNT(DISTINCT R.hc) > 1
) X;


SELECT 'Rentals: s --> pid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.s
        FROM Rentals R
        GROUP BY R.s
        HAVING COUNT(DISTINCT R.pid) > 1
) X;


SELECT 'Rentals: s --> hid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.s
        FROM Rentals R
        GROUP BY R.s
        HAVING COUNT(DISTINCT R.hid) > 1
) X;


SELECT 'Rentals: s --> pn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.s
        FROM Rentals R
        GROUP BY R.s
        HAVING COUNT(DISTINCT R.pn) > 1
) X;


SELECT 'Rentals: s --> hs' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.s
        FROM Rentals R
        GROUP BY R.s
        HAVING COUNT(DISTINCT R.hs) > 1
) X;


SELECT 'Rentals: s --> hz' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.s
        FROM Rentals R
        GROUP BY R.s
        HAVING COUNT(DISTINCT R.hz) > 1
) X;


SELECT 'Rentals: s --> hc' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.s
        FROM Rentals R
        GROUP BY R.s
        HAVING COUNT(DISTINCT R.hc) > 1
) X;


SELECT 'Rentals: hs --> pid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hs
        FROM Rentals R
        GROUP BY R.hs
        HAVING COUNT(DISTINCT R.pid) > 1
) X;


SELECT 'Rentals: hs --> hid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hs
        FROM Rentals R
        GROUP BY R.hs
        HAVING COUNT(DISTINCT R.hid) > 1
) X;


SELECT 'Rentals: hs --> pn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hs
        FROM Rentals R
        GROUP BY R.hs
        HAVING COUNT(DISTINCT R.pn) > 1
) X;


SELECT 'Rentals: hs --> s' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hs
        FROM Rentals R
        GROUP BY R.hs
        HAVING COUNT(DISTINCT R.s) > 1
) X;


SELECT 'Rentals: hs --> hz' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hs
        FROM Rentals R
        GROUP BY R.hs
        HAVING COUNT(DISTINCT R.hz) > 1
) X;


SELECT 'Rentals: hs --> hc' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hs
        FROM Rentals R
        GROUP BY R.hs
        HAVING COUNT(DISTINCT R.hc) > 1
) X;


SELECT 'Rentals: hz --> pid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hz
        FROM Rentals R
        GROUP BY R.hz
        HAVING COUNT(DISTINCT R.pid) > 1
) X;


SELECT 'Rentals: hz --> hid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hz
        FROM Rentals R
        GROUP BY R.hz
        HAVING COUNT(DISTINCT R.hid) > 1
) X;


SELECT 'Rentals: hz --> pn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hz
        FROM Rentals R
        GROUP BY R.hz
        HAVING COUNT(DISTINCT R.pn) > 1
) X;


SELECT 'Rentals: hz --> s' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hz
        FROM Rentals R
        GROUP BY R.hz
        HAVING COUNT(DISTINCT R.s) > 1
) X;


SELECT 'Rentals: hz --> hs' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hz
        FROM Rentals R
        GROUP BY R.hz
        HAVING COUNT(DISTINCT R.hs) > 1
) X;


SELECT 'Rentals: hz --> hc' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hz
        FROM Rentals R
        GROUP BY R.hz
        HAVING COUNT(DISTINCT R.hc) > 1
) X;


SELECT 'Rentals: hc --> pid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hc
        FROM Rentals R
        GROUP BY R.hc
        HAVING COUNT(DISTINCT R.pid) > 1
) X;


SELECT 'Rentals: hc --> hid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hc
        FROM Rentals R
        GROUP BY R.hc
        HAVING COUNT(DISTINCT R.hid) > 1
) X;


SELECT 'Rentals: hc --> pn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hc
        FROM Rentals R
        GROUP BY R.hc
        HAVING COUNT(DISTINCT R.pn) > 1
) X;


SELECT 'Rentals: hc --> s' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hc
        FROM Rentals R
        GROUP BY R.hc
        HAVING COUNT(DISTINCT R.s) > 1
) X;


SELECT 'Rentals: hc --> hs' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hc
        FROM Rentals R
        GROUP BY R.hc
        HAVING COUNT(DISTINCT R.hs) > 1
) X;


SELECT 'Rentals: hc --> hz' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.hc
        FROM Rentals R
        GROUP BY R.hc
        HAVING COUNT(DISTINCT R.hz) > 1
) X;

-- Output:
          fd          |   validity    
----------------------+---------------
 Rentals: pid --> hid | does not hold
(1 row)

         fd          | validity 
---------------------+----------
 Rentals: pid --> pn | MAY HOLD
(1 row)

         fd         |   validity    
--------------------+---------------
 Rentals: pid --> s | does not hold
(1 row)

         fd          |   validity    
---------------------+---------------
 Rentals: pid --> hs | does not hold
(1 row)

         fd          |   validity    
---------------------+---------------
 Rentals: pid --> hz | does not hold
(1 row)

         fd          |   validity    
---------------------+---------------
 Rentals: pid --> hc | does not hold
(1 row)

          fd          |   validity    
----------------------+---------------
 Rentals: hid --> pid | does not hold
(1 row)

         fd          |   validity    
---------------------+---------------
 Rentals: hid --> pn | does not hold
(1 row)

         fd         |   validity    
--------------------+---------------
 Rentals: hid --> s | does not hold
(1 row)

         fd          | validity 
---------------------+----------
 Rentals: hid --> hs | MAY HOLD
(1 row)

         fd          | validity 
---------------------+----------
 Rentals: hid --> hz | MAY HOLD
(1 row)

         fd          | validity 
---------------------+----------
 Rentals: hid --> hc | MAY HOLD
(1 row)

         fd          |   validity    
---------------------+---------------
 Rentals: pn --> pid | does not hold
(1 row)

         fd          |   validity    
---------------------+---------------
 Rentals: pn --> hid | does not hold
(1 row)

        fd         |   validity    
-------------------+---------------
 Rentals: pn --> s | does not hold
(1 row)

         fd         |   validity    
--------------------+---------------
 Rentals: pn --> hs | does not hold
(1 row)

         fd         |   validity    
--------------------+---------------
 Rentals: pn --> hz | does not hold
(1 row)

         fd         |   validity    
--------------------+---------------
 Rentals: pn --> hc | does not hold
(1 row)

         fd         |   validity    
--------------------+---------------
 Rentals: s --> pid | does not hold
(1 row)

         fd         |   validity    
--------------------+---------------
 Rentals: s --> hid | does not hold
(1 row)

        fd         |   validity    
-------------------+---------------
 Rentals: s --> pn | does not hold
(1 row)

        fd         |   validity    
-------------------+---------------
 Rentals: s --> hs | does not hold
(1 row)

        fd         |   validity    
-------------------+---------------
 Rentals: s --> hz | does not hold
(1 row)

        fd         |   validity    
-------------------+---------------
 Rentals: s --> hc | does not hold
(1 row)

         fd          |   validity    
---------------------+---------------
 Rentals: hs --> pid | does not hold
(1 row)

         fd          |   validity    
---------------------+---------------
 Rentals: hs --> hid | does not hold
(1 row)

         fd         |   validity    
--------------------+---------------
 Rentals: hs --> pn | does not hold
(1 row)

        fd         |   validity    
-------------------+---------------
 Rentals: hs --> s | does not hold
(1 row)

         fd         |   validity    
--------------------+---------------
 Rentals: hs --> hz | does not hold
(1 row)

         fd         |   validity    
--------------------+---------------
 Rentals: hs --> hc | does not hold
(1 row)

         fd          |   validity    
---------------------+---------------
 Rentals: hz --> pid | does not hold
(1 row)

         fd          |   validity    
---------------------+---------------
 Rentals: hz --> hid | does not hold
(1 row)

         fd         |   validity    
--------------------+---------------
 Rentals: hz --> pn | does not hold
(1 row)

        fd         |   validity    
-------------------+---------------
 Rentals: hz --> s | does not hold
(1 row)

         fd         |   validity    
--------------------+---------------
 Rentals: hz --> hs | does not hold
(1 row)

         fd         | validity 
--------------------+----------
 Rentals: hz --> hc | MAY HOLD
(1 row)

         fd          |   validity    
---------------------+---------------
 Rentals: hc --> pid | does not hold
(1 row)

         fd          |   validity    
---------------------+---------------
 Rentals: hc --> hid | does not hold
(1 row)

         fd         |   validity    
--------------------+---------------
 Rentals: hc --> pn | does not hold
(1 row)

        fd         |   validity    
-------------------+---------------
 Rentals: hc --> s | does not hold
(1 row)

         fd         |   validity    
--------------------+---------------
 Rentals: hc --> hs | does not hold
(1 row)

         fd         |   validity    
--------------------+---------------
 Rentals: hc --> hz | does not hold
(1 row)