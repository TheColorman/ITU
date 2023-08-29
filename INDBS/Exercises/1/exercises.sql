DROP TABLE IF EXISTS Sells;
DROP TABLE IF EXISTS Coffees;
DROP TABLE IF EXISTS Coffeehouses;

CREATE TABLE Coffees (
	Name VARCHAR(25) PRIMARY KEY,
	Manufacturer VARCHAR(25) NOT NULL
);

CREATE TABLE Coffeehouses (
	Name VARCHAR(25) PRIMARY KEY,
	Address VARCHAR(50) NOT NULL,
	License VARCHAR(50) NOT NULL
);

CREATE TABLE Sells (
	Coffeehouse VARCHAR(25),
	Coffee VARCHAR(25),
	Price INT,
	PRIMARY KEY (Coffeehouse, Coffee),
	FOREIGN KEY (Coffeehouse) REFERENCES Coffeehouses (Name),
	FOREIGN KEY (Coffee) REFERENCES Coffees (Name)
);