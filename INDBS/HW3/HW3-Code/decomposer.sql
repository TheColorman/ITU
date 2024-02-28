CREATE TABLE People (
    ID INT PRIMARY KEY,
    Name VARCHAR(50)
);
CREATE TABLE Zip (
    Zip INT PRIMARY KEY,
    City VARCHAR(50)
);
CREATE TABLE Houses (
    ID INT PRIMARY KEY,
    Street VARCHAR(50),
    Zip INT,
        FOREIGN KEY (Zip) REFERENCES Zip(Zip)
);
CREATE TABLE Renters (
    PersonID INT,
    HouseID INT,
    S int,
        PRIMARY KEY (PersonID, HouseID),
        FOREIGN KEY (PersonID) REFERENCES People(ID),
        FOREIGN KEY (HouseID) REFERENCES Houses(ID)
);

INSERT INTO People
SELECT pid, pn FROM rentals
GROUP BY pid, pn; -- Each renter can rent multiple houses, and each house can be rented by multiple people
INSERT INTO Zip
SELECT hz, hc FROM rentals
GROUP BY hz, hc;
INSERT INTO Houses
SELECT hid, hs, hz FROM rentals
GROUP BY hid, hs, hz;
INSERT INTO Renters
SELECT pid, hid, s FROM rentals;