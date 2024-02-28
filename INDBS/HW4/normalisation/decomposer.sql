CREATE TABLE Projects_new (
    id INT PRIMARY KEY,
    mid INT
);
CREATE TABLE M (
    mid INT PRIMARY KEY,
    mn VARCHAR(50),
        FOREIGN KEY (mid) REFERENCES Projects_new(mid)
);
CREATE TABLE P (
    pid INTEGER PRIMARY KEY,
    pn VARCHAR(50)
);
CREATE TABLE S (
    sid INTEGER PRIMARY KEY,
    sn VARCHAR(50)
);

INSERT INTO Projects_new
SELECT id, mid FROM projects
GROUP BY id, mid;
INSERT INTO M
SELECT mid, mn FROM projects
GROUP BY mid, mn;
INSERT INTO P
SELECT pid, pn FROM projects
GROUP BY pid, pn;
INSERT INTO S
SELECT sid, sn FROM projects
GROUP BY sid, sn;