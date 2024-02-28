
SELECT 'Projects: id --> pid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.id
        FROM Projects R
        GROUP BY R.id
        HAVING COUNT(DISTINCT R.pid) > 1
) X;


SELECT 'Projects: id --> sid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.id
        FROM Projects R
        GROUP BY R.id
        HAVING COUNT(DISTINCT R.sid) > 1
) X;


SELECT 'Projects: id --> sn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.id
        FROM Projects R
        GROUP BY R.id
        HAVING COUNT(DISTINCT R.sn) > 1
) X;


SELECT 'Projects: id --> pn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.id
        FROM Projects R
        GROUP BY R.id
        HAVING COUNT(DISTINCT R.pn) > 1
) X;


SELECT 'Projects: id --> mid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.id
        FROM Projects R
        GROUP BY R.id
        HAVING COUNT(DISTINCT R.mid) > 1
) X;


SELECT 'Projects: id --> mn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.id
        FROM Projects R
        GROUP BY R.id
        HAVING COUNT(DISTINCT R.mn) > 1
) X;


SELECT 'Projects: pid --> id' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pid
        FROM Projects R
        GROUP BY R.pid
        HAVING COUNT(DISTINCT R.id) > 1
) X;


SELECT 'Projects: pid --> sid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pid
        FROM Projects R
        GROUP BY R.pid
        HAVING COUNT(DISTINCT R.sid) > 1
) X;


SELECT 'Projects: pid --> sn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pid
        FROM Projects R
        GROUP BY R.pid
        HAVING COUNT(DISTINCT R.sn) > 1
) X;


SELECT 'Projects: pid --> pn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pid
        FROM Projects R
        GROUP BY R.pid
        HAVING COUNT(DISTINCT R.pn) > 1
) X;


SELECT 'Projects: pid --> mid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pid
        FROM Projects R
        GROUP BY R.pid
        HAVING COUNT(DISTINCT R.mid) > 1
) X;


SELECT 'Projects: pid --> mn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pid
        FROM Projects R
        GROUP BY R.pid
        HAVING COUNT(DISTINCT R.mn) > 1
) X;


SELECT 'Projects: sid --> id' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.sid
        FROM Projects R
        GROUP BY R.sid
        HAVING COUNT(DISTINCT R.id) > 1
) X;


SELECT 'Projects: sid --> pid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.sid
        FROM Projects R
        GROUP BY R.sid
        HAVING COUNT(DISTINCT R.pid) > 1
) X;


SELECT 'Projects: sid --> sn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.sid
        FROM Projects R
        GROUP BY R.sid
        HAVING COUNT(DISTINCT R.sn) > 1
) X;


SELECT 'Projects: sid --> pn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.sid
        FROM Projects R
        GROUP BY R.sid
        HAVING COUNT(DISTINCT R.pn) > 1
) X;


SELECT 'Projects: sid --> mid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.sid
        FROM Projects R
        GROUP BY R.sid
        HAVING COUNT(DISTINCT R.mid) > 1
) X;


SELECT 'Projects: sid --> mn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.sid
        FROM Projects R
        GROUP BY R.sid
        HAVING COUNT(DISTINCT R.mn) > 1
) X;


SELECT 'Projects: sn --> id' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.sn
        FROM Projects R
        GROUP BY R.sn
        HAVING COUNT(DISTINCT R.id) > 1
) X;


SELECT 'Projects: sn --> pid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.sn
        FROM Projects R
        GROUP BY R.sn
        HAVING COUNT(DISTINCT R.pid) > 1
) X;


SELECT 'Projects: sn --> sid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.sn
        FROM Projects R
        GROUP BY R.sn
        HAVING COUNT(DISTINCT R.sid) > 1
) X;


SELECT 'Projects: sn --> pn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.sn
        FROM Projects R
        GROUP BY R.sn
        HAVING COUNT(DISTINCT R.pn) > 1
) X;


SELECT 'Projects: sn --> mid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.sn
        FROM Projects R
        GROUP BY R.sn
        HAVING COUNT(DISTINCT R.mid) > 1
) X;


SELECT 'Projects: sn --> mn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.sn
        FROM Projects R
        GROUP BY R.sn
        HAVING COUNT(DISTINCT R.mn) > 1
) X;


SELECT 'Projects: pn --> id' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pn
        FROM Projects R
        GROUP BY R.pn
        HAVING COUNT(DISTINCT R.id) > 1
) X;


SELECT 'Projects: pn --> pid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pn
        FROM Projects R
        GROUP BY R.pn
        HAVING COUNT(DISTINCT R.pid) > 1
) X;


SELECT 'Projects: pn --> sid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pn
        FROM Projects R
        GROUP BY R.pn
        HAVING COUNT(DISTINCT R.sid) > 1
) X;


SELECT 'Projects: pn --> sn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pn
        FROM Projects R
        GROUP BY R.pn
        HAVING COUNT(DISTINCT R.sn) > 1
) X;


SELECT 'Projects: pn --> mid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pn
        FROM Projects R
        GROUP BY R.pn
        HAVING COUNT(DISTINCT R.mid) > 1
) X;


SELECT 'Projects: pn --> mn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.pn
        FROM Projects R
        GROUP BY R.pn
        HAVING COUNT(DISTINCT R.mn) > 1
) X;


SELECT 'Projects: mid --> id' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.mid
        FROM Projects R
        GROUP BY R.mid
        HAVING COUNT(DISTINCT R.id) > 1
) X;


SELECT 'Projects: mid --> pid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.mid
        FROM Projects R
        GROUP BY R.mid
        HAVING COUNT(DISTINCT R.pid) > 1
) X;


SELECT 'Projects: mid --> sid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.mid
        FROM Projects R
        GROUP BY R.mid
        HAVING COUNT(DISTINCT R.sid) > 1
) X;


SELECT 'Projects: mid --> sn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.mid
        FROM Projects R
        GROUP BY R.mid
        HAVING COUNT(DISTINCT R.sn) > 1
) X;


SELECT 'Projects: mid --> pn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.mid
        FROM Projects R
        GROUP BY R.mid
        HAVING COUNT(DISTINCT R.pn) > 1
) X;


SELECT 'Projects: mid --> mn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.mid
        FROM Projects R
        GROUP BY R.mid
        HAVING COUNT(DISTINCT R.mn) > 1
) X;


SELECT 'Projects: mn --> id' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.mn
        FROM Projects R
        GROUP BY R.mn
        HAVING COUNT(DISTINCT R.id) > 1
) X;


SELECT 'Projects: mn --> pid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.mn
        FROM Projects R
        GROUP BY R.mn
        HAVING COUNT(DISTINCT R.pid) > 1
) X;


SELECT 'Projects: mn --> sid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.mn
        FROM Projects R
        GROUP BY R.mn
        HAVING COUNT(DISTINCT R.sid) > 1
) X;


SELECT 'Projects: mn --> sn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.mn
        FROM Projects R
        GROUP BY R.mn
        HAVING COUNT(DISTINCT R.sn) > 1
) X;


SELECT 'Projects: mn --> pn' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.mn
        FROM Projects R
        GROUP BY R.mn
        HAVING COUNT(DISTINCT R.pn) > 1
) X;


SELECT 'Projects: mn --> mid' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT R.mn
        FROM Projects R
        GROUP BY R.mn
        HAVING COUNT(DISTINCT R.mid) > 1
) X;

