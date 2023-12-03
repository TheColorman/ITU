CREATE TABLE Promise (
    ID INT PRIMARY KEY,
    Description VARCHAR(255)
);
CREATE TABLE SacrificeCategories (
    ID INT PRIMARY KEY,
    Name VARCHAR(9), -- valuables is 9 chars
    Attribute VARCHAR(255)
);
CREATE TABLE Human (
    ID INT PRIMARY KEY
);
CREATE TABLE Priest (
    HumanID INT PRIMARY KEY,
    God VARCHAR(50),
        FOREIGN KEY HumanID REFERENCES Human(ID)
);
CREATE TABLE Sacrifice (
    ID INT PRIMARY KEY,
    Time TIMESTAMP,
    Place VARCHAR(255),
    CategoryID INT,
    Value INT,
    HumanID INT,
    PriestID INT,
    God VARCHAR(50),
        FOREIGN KEY CategoryID REFERENCES SacrificeCategories(ID),
        FOREIGN KEY HumanID REFERENCES Human(ID),
        FOREIGN KEY PriestID REFERENCES Priest(HumanID)
);
CREATE TABLE SacrificeItems (
    SacrificeID INT,
    Item VARCHAR(50),
        PRIMARY KEY (SacrificeID, Item),
        FOREIGN KEY SacrificeID REFERENCES Sacrifice(ID)
);
CREATE TABLE Attack (
    ID INT,
    HumanID INT,
        PRIMARY KEY (ID, HumanID),
        FOREIGN KEY HumanID REFERENCES Human(ID)
);
CREATE TABLE Victim (
    ID INT,
    AttackID INT,
    Species VARCHAR(255),
        PRIMARY KEY (ID, AttackID),
        FOREIGN KEY AttackID REFERENCES Attack(ID)
);

INSERT INTO
    SacrificeCategories (ID, Name)
VALUES
    (0, 'Flesh'),
    (1, 'Wine'),
    (2, 'Valuables');

CREATE FUNCTION CheckPriest()
RETURNS TRIGGER
AS $$
DECLARE
    SeaMonsterOrCyclopVictims INTEGER;
BEGIN 
	IF (NEW.priestID) IS NOT NULL THEN
		NEW.value := NEW.value * 2
	END IF; 
    
	RETURN NEW; 
END; $$ LANGUAGE plpgsql; 
CREATE TRIGGER CheckPriest 
BEFORE INSERT OR UPDATE
ON Sacrifice
FOR EACH ROW EXECUTE PROCEDURE CheckPriest();

CREATE FUNCTION GetTotalSacrificeValue(HumanID INT)
RETURNS INTEGER
AS $$
DECLARE
    totalvalue INTEGER;
    hecatomb INTEGER;
BEGIN
    hecatomb := 5; -- Tell Poseidon to update this
    BEGIN
        SELECT SUM(Sacrifice.Value) INTO totalvalue
        FROM Sacrifice
        WHERE Sacrifice.HumanID = HumanID;
    END;

    BEGIN
        SELECT COUNT(*) INTO SeaMonsterOrCyclopVictims
        FROM Victim
        JOIN Attack ON
            Victim.AttackID = Attack.ID
        WHERE
            Attack.HumanID = NEW.HumanID AND 
            Victim.Species IN ('Sea Monster', 'Cyclops');
    END;
    IF (SeaMonsterOrCyclopVictims > 0) THEN
        totalvalue = totalvalue - hecatomb;
    END IF;
END; $$ LANGUAGE plpgsql;