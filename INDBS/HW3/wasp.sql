-- Reset
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;

-- I am going to assume that values can be NULL unless otherwise stated
-- 1.
CREATE TABLE People (
    ID INT PRIMARY KEY,
    name VARCHAR(100), -- Complex unicode characters probably take up more space
    address VARCHAR(200),
    phone VARCHAR(20), -- Plusses and parentheses
    DOB DATE,
    DOD DATE
);

-- 2.
CREATE TABLE Member (
    PersonID INT PRIMARY KEY REFERENCES People(ID),
    Start_date DATE
);
CREATE TABLE Enemy (
    PersonID INT PRIMARY KEY REFERENCES People(ID),
    Reason VARCHAR(200)
);

-- 3.
CREATE TABLE Asset (
    Name VARCHAR(20) PRIMARY KEY,
    MemberID INT,
    Detail VARCHAR(200),
    Uses VARCHAR(200),
        FOREIGN KEY (MemberID) REFERENCES Member(PersonID)
);

-- 4.
-- I don't think there's any way to enforce that at least 2 people have to be added when adding a new Linking
CREATE TABLE Linking (
    ID INT PRIMARY KEY,
    Name VARCHAR(20),
    Type VARCHAR(10),
    Description VARCHAR(100)
);
CREATE TABLE Participate (
    PersonID INT,
    LinkingID INT,
        PRIMARY KEY (PersonID, LinkingID),
        FOREIGN KEY (PersonID) REFERENCES People(ID),
        FOREIGN KEY (LinkingID) REFERENCES Linking(ID)
);

-- 5.
CREATE TABLE Monitors_Linking (
    MemberID INT, -- Each monitor can have multiple linkings
    LinkingID INT UNIQUE, -- Each linking has 1 monitor
        PRIMARY KEY (MemberID, LinkingID),
        FOREIGN KEY (MemberID) REFERENCES Member(PersonID),
        FOREIGN KEY (LinkingID) REFERENCES Linking(ID)
);

-- 6.
CREATE TABLE Role (
    ID INT PRIMARY KEY,
    Title VARCHAR(20),
    Salary INT
);
CREATE TABLE Serves_in (
    MemberID INT, -- One person can have multiple roles
    RoleID INT, -- One role can have multiple people
    Start_date DATE NOT NULL,
    End_date DATE NOT NULL,
        PRIMARY KEY (MemberID, RoleID), -- But the a person cannot have the same role twice
        FOREIGN KEY (MemberID) REFERENCES Member(PersonID),
        FOREIGN KEY (RoleID) REFERENCES Role(ID)
);

-- 7.
CREATE TABLE Party (
    ID INT PRIMARY KEY,
    Country VARCHAR(28) NOT NULL, -- https://worldpopulationreview.com/country-rankings/country-with-the-longest-name
    Name VARCHAR(100)
);
-- Played around a bit with overlapping date constraints (https://stackoverflow.com/questions/10616099/postgres-date-overlapping-constraint) but no luck getting something that worked properly.
CREATE TABLE Monitors_Party (
    MemberID INT,
    PartyID INT UNIQUE, -- Each party is only monitored once
    Start_date DATE NOT NULL,
    End_date DATE,
    Log VARCHAR(255),
        PRIMARY KEY (MemberID, PartyID),
        FOREIGN KEY (MemberID) REFERENCES Member(PersonID),
        FOREIGN KEY (PartyID) REFERENCES Party(ID)
);

-- 8.
CREATE TABLE Ally (
    Alias VARCHAR(20) PRIMARY KEY,
    Trust_level INT
        CONSTRAINT trust_levels 
        CHECK (Trust_level >= 1 AND Trust_level <= 5)
);
-- Multi-valued attribute table
CREATE TABLE Ally_Benefits (
    AllyAlias VARCHAR(20) PRIMARY KEY,
    Value VARCHAR(255),
        FOREIGN KEY (AllyAlias) REFERENCES Ally(Alias)
);
CREATE TABLE Affiliates (
    AllyAlias VARCHAR(20),
    MemberID INT,
        PRIMARY KEY (AllyAlias, MemberID),
        FOREIGN KEY (AllyAlias) REFERENCES Ally(Alias),
        FOREIGN KEY (MemberID) REFERENCES Member(PersonID)
);
CREATE TABLE Supports (
    AllyAlias VARCHAR(20),
    PartyID INT,
        PRIMARY KEY (AllyAlias, PartyID),
        FOREIGN KEY (AllyAlias) REFERENCES Ally(Alias),
        FOREIGN KEY (PartyID) REFERENCES Party(ID)
);

-- 9.
CREATE TABLE Sponsor (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(200),
    Industry VARCHAR(40)
);
CREATE TABLE Grants (
    SponsorID INT,
    MemberID INT,
    Date DATE,
    Amount INT,
    Payback VARCHAR(200),
        PRIMARY KEY (SponsorID, MemberID, Date),
        FOREIGN KEY (SponsorID) REFERENCES Sponsor(ID),
        FOREIGN KEY (MemberID) REFERENCES Member(PersonID)
);

-- 10.
CREATE TABLE Grant_Reviews (
    ReviewerID INT,
    SponsorID INT,
    ReceiverID INT,
    GrantDate DATE,
    ReviewDate DATE,
    Grade INT
        CONSTRAINT grade_lelels 
        CHECK (Grade >= 1 AND Grade <= 10),
        PRIMARY KEY ( ReviewerID, SponsorID, ReceiverID, GrantDate),
        FOREIGN KEY
            (SponsorID, ReceiverID, GrantDate)
        REFERENCES
            Grants(SponsorID, MemberID, Date)
);

-- 11.
CREATE TABLE Opponent (
    ID INT PRIMARY KEY
);
ALTER TABLE Party
    ADD OpponentID INT UNIQUE,
    ADD CONSTRAINT fk_opponentid FOREIGN KEY (OpponentID) REFERENCES Opponent(ID);
ALTER TABLE Enemy
    ADD OpponentID INT UNIQUE,
    ADD CONSTRAINT fk_opponentid FOREIGN KEY (OpponentID) REFERENCES Opponent(ID);
CREATE TABLE Opposes (
    OpponentID INT,
    MemberID INT,
    Start_date DATE NOT NULL,
    End_date DATE,
        PRIMARY KEY (OpponentID, MemberID),
        FOREIGN KEY (OpponentID) REFERENCES Opponent(ID),
        FOREIGN KEY (MemberID) REFERENCES Member(PersonID)
);