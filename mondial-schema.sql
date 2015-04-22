
CREATE TABLE Country
(Name VARCHAR(35) NOT NULL UNIQUE,
 Code VARCHAR(4) CONSTRAINT CountryKey PRIMARY KEY,
 Capital VARCHAR(35),
 Province VARCHAR(35),
 Area NUMERIC CONSTRAINT CountryArea
   CHECK (Area >= 0),
 Population NUMERIC CONSTRAINT CountryPop
   CHECK (Population >= 0));

CREATE TABLE City
(Name VARCHAR(35),
 Country VARCHAR(4),
 Province VARCHAR(35),
 Population NUMERIC CONSTRAINT CityPop
   CHECK (Population >= 0),
 Longitude NUMERIC CONSTRAINT CityLon
   CHECK ((Longitude >= -180) AND (Longitude <= 180)) ,
 Latitude NUMERIC CONSTRAINT CityLat
   CHECK ((Latitude >= -90) AND (Latitude <= 90)) ,
 CONSTRAINT CityKey PRIMARY KEY (Name, Country, Province));

CREATE TABLE Province
(Name VARCHAR(35) CONSTRAINT PrName NOT NULL ,
 Country  VARCHAR(4) CONSTRAINT PrCountry NOT NULL
   REFERENCES Country DEFERRABLE INITIALLY DEFERRED,
 Population NUMERIC CONSTRAINT PrPop
   CHECK (Population >= 0),
 Area NUMERIC CONSTRAINT PrAr
   CHECK (Area >= 0),
 Capital VARCHAR(35),
 CapProv VARCHAR(35),
 CONSTRAINT PrKey PRIMARY KEY (Name, Country));

ALTER TABLE Country
  ADD CONSTRAINT Capital_FKey FOREIGN KEY (Capital, Code, Province)
  REFERENCES City(Name, Country, Province) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE City
  ADD CONSTRAINT Province_FKey FOREIGN KEY (Province, Country)
  REFERENCES Province(Name, Country) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Province
  ADD CONSTRAINT Capital_FKey FOREIGN KEY (Capital, Country, CapProv)
  REFERENCES City(Name, Country, Province) DEFERRABLE INITIALLY DEFERRED;

CREATE TABLE Economy
(Country VARCHAR(4) CONSTRAINT EconomyKey PRIMARY KEY
   REFERENCES Country DEFERRABLE INITIALLY DEFERRED,
 GDP NUMERIC CONSTRAINT EconomyGDP
   CHECK (GDP >= 0),
 Agriculture NUMERIC,
 Service NUMERIC,
 Industry NUMERIC,
 Inflation NUMERIC);

CREATE TABLE Population
(Country VARCHAR(4) CONSTRAINT PopKey PRIMARY KEY
   REFERENCES Country DEFERRABLE INITIALLY DEFERRED,
 Population_Growth NUMERIC,
 Infant_Mortality NUMERIC);

CREATE TABLE Politics
(Country VARCHAR(4) CONSTRAINT PoliticsKey PRIMARY KEY
   REFERENCES Country DEFERRABLE INITIALLY DEFERRED,
 Independence DATE,
 Dependent  VARCHAR(4)
   REFERENCES Country DEFERRABLE INITIALLY DEFERRED,
 Government VARCHAR(120));

CREATE TABLE Language
(Country VARCHAR(4)
   REFERENCES Country DEFERRABLE INITIALLY DEFERRED,
 Name VARCHAR(50),
 Percentage NUMERIC CONSTRAINT LanguagePercent
   CHECK ((Percentage > 0) AND (Percentage <= 100)),
 CONSTRAINT LanguageKey PRIMARY KEY (Name, Country));

CREATE TABLE Religion
(Country VARCHAR(4)
   REFERENCES Country DEFERRABLE INITIALLY DEFERRED,
 Name VARCHAR(50),
 Percentage NUMERIC CONSTRAINT ReligionPercent
   CHECK ((Percentage > 0) AND (Percentage <= 100)),
 CONSTRAINT ReligionKey PRIMARY KEY (Name, Country));

CREATE TABLE EthnicGroup
(Country VARCHAR(4)
   REFERENCES Country DEFERRABLE INITIALLY DEFERRED,
 Name VARCHAR(50),
 Percentage NUMERIC CONSTRAINT EthnicPercent
   CHECK ((Percentage > 0) AND (Percentage <= 100)),
 CONSTRAINT EthnicKey PRIMARY KEY (Name, Country));

CREATE TABLE Continent
(Name VARCHAR(20) CONSTRAINT ContinentKey PRIMARY KEY,
 Area NUMERIC(10));

CREATE TABLE borders
(Country1 VARCHAR(4)
   REFERENCES Country DEFERRABLE INITIALLY DEFERRED,
 Country2 VARCHAR(4)
   REFERENCES Country DEFERRABLE INITIALLY DEFERRED,
 Length NUMERIC
   CHECK (Length > 0),
 CONSTRAINT BorderKey PRIMARY KEY (Country1,Country2) );

CREATE TABLE encompasses
(Country VARCHAR(4) NOT NULL
   REFERENCES Country DEFERRABLE INITIALLY DEFERRED,
 Continent VARCHAR(20) NOT NULL
   REFERENCES Continent DEFERRABLE INITIALLY DEFERRED,
 Percentage NUMERIC,
   CHECK ((Percentage > 0) AND (Percentage <= 100)),
 CONSTRAINT EncompassesKey PRIMARY KEY (Country,Continent));

CREATE TABLE Organization
(Abbreviation VARCHAR(12) PRIMARY KEY,
 Name VARCHAR(80) NOT NULL,
 City VARCHAR(35) ,
 Country VARCHAR(4) ,
 Province VARCHAR(35) ,
 Established DATE,
 CONSTRAINT OrgNameUnique UNIQUE (Name),
 CONSTRAINT City_FKey FOREIGN KEY (City, Country, Province)
   REFERENCES City(Name, Country, Province) DEFERRABLE INITIALLY DEFERRED);

CREATE TABLE isMember
(Country VARCHAR(4)
   REFERENCES Country DEFERRABLE INITIALLY DEFERRED,
 Organization VARCHAR(12)
   REFERENCES Organization DEFERRABLE INITIALLY DEFERRED,
 Type VARCHAR(35) DEFAULT 'member',
 CONSTRAINT MemberKey PRIMARY KEY (Country,Organization) );

CREATE TYPE GeoCoord AS (Longitude DECIMAL, Latitude DECIMAL);

CREATE TABLE Mountain
(Name VARCHAR(35) CONSTRAINT MountainKey PRIMARY KEY,
 Mountains VARCHAR(35),
 Height NUMERIC,
 Type VARCHAR(10),
 Coordinates GeoCoord CONSTRAINT MountainCoord
     CHECK (((Coordinates).Longitude >= -180) AND
            ((Coordinates).Longitude <= 180) AND
            ((Coordinates).Latitude >= -90) AND
            ((Coordinates).Latitude <= 90)));

CREATE TABLE Desert
(Name VARCHAR(35) CONSTRAINT DesertKey PRIMARY KEY,
 Area NUMERIC,
 Coordinates GeoCoord CONSTRAINT DesCoord
     CHECK (((Coordinates).Longitude >= -180) AND
            ((Coordinates).Longitude <= 180) AND
            ((Coordinates).Latitude >= -90) AND
            ((Coordinates).Latitude <= 90)));

CREATE TABLE Island
(Name VARCHAR(35) CONSTRAINT IslandKey PRIMARY KEY,
 Islands VARCHAR(35),
 Area NUMERIC CONSTRAINT IslandAr check (Area >= 0),
 Height NUMERIC,
 Type VARCHAR(10),
 Coordinates GeoCoord CONSTRAINT IslandCoord
     CHECK (((Coordinates).Longitude >= -180) AND
            ((Coordinates).Longitude <= 180) AND
            ((Coordinates).Latitude >= -90) AND
            ((Coordinates).Latitude <= 90)));

CREATE TABLE Lake
(Name VARCHAR(35) CONSTRAINT LakeKey PRIMARY KEY,
 Area NUMERIC CONSTRAINT LakeAr CHECK (Area >= 0),
 Depth NUMERIC CONSTRAINT LakeDpth CHECK (Depth >= 0),
 Altitude NUMERIC,
 Type VARCHAR(10),
 River VARCHAR(35),
 Coordinates GeoCoord CONSTRAINT LakeCoord
     CHECK (((Coordinates).Longitude >= -180) AND
            ((Coordinates).Longitude <= 180) AND
            ((Coordinates).Latitude >= -90) AND
            ((Coordinates).Latitude <= 90)));

CREATE TABLE Sea
(Name VARCHAR(35) CONSTRAINT SeaKey PRIMARY KEY,
 Depth NUMERIC CONSTRAINT SeaDepth CHECK (Depth >= 0));

CREATE TABLE River
(Name VARCHAR(35) CONSTRAINT RiverKey PRIMARY KEY,
 River VARCHAR(35)
   REFERENCES River DEFERRABLE INITIALLY DEFERRED,
 Lake VARCHAR(35)
   REFERENCES Lake DEFERRABLE INITIALLY DEFERRED,
 Sea VARCHAR(35)
   REFERENCES Sea DEFERRABLE INITIALLY DEFERRED,
 Length NUMERIC CONSTRAINT RiverLength
   CHECK (Length >= 0),
 Source GeoCoord CONSTRAINT SourceCoord
     CHECK (((Source).Longitude >= -180) AND
            ((Source).Longitude <= 180) AND
            ((Source).Latitude >= -90) AND
            ((Source).Latitude <= 90)),
 Mountains VARCHAR(35),
 SourceAltitude NUMERIC,
 Estuary GeoCoord CONSTRAINT EstCoord
     CHECK (((Estuary).Longitude >= -180) AND
            ((Estuary).Longitude <= 180) AND
            ((Estuary).Latitude >= -90) AND
            ((Estuary).Latitude <= 90)));

ALTER TABLE Lake
  ADD CONSTRAINT River_FKey FOREIGN KEY (River)
  REFERENCES River(Name) DEFERRABLE INITIALLY DEFERRED;

CREATE TABLE geo_Mountain
(Mountain VARCHAR(35)
   REFERENCES Mountain DEFERRABLE INITIALLY DEFERRED,
 Country VARCHAR(4) ,
 Province VARCHAR(35) ,
 CONSTRAINT GMountainKey PRIMARY KEY (Province,Country,Mountain),
 CONSTRAINT Province_FKey FOREIGN KEY (Province, Country)
   REFERENCES Province(Name, Country) DEFERRABLE INITIALLY DEFERRED);

CREATE TABLE geo_Desert
(Desert VARCHAR(35)
   REFERENCES Desert DEFERRABLE INITIALLY DEFERRED,
 Country VARCHAR(4) ,
 Province VARCHAR(35) ,
 CONSTRAINT GDesertKey PRIMARY KEY (Province, Country, Desert),
 CONSTRAINT Province_FKey FOREIGN KEY (Province, Country)
   REFERENCES Province(Name, Country) DEFERRABLE INITIALLY DEFERRED);

CREATE TABLE geo_Island
(Island VARCHAR(35)
   REFERENCES Island DEFERRABLE INITIALLY DEFERRED,
 Country VARCHAR(4) ,
 Province VARCHAR(35) ,
 CONSTRAINT GIslandKey PRIMARY KEY (Province, Country, Island),
 CONSTRAINT Province_FKey FOREIGN KEY (Province, Country)
   REFERENCES Province(Name, Country) DEFERRABLE INITIALLY DEFERRED);

CREATE TABLE geo_River
(River VARCHAR(35)
   REFERENCES River DEFERRABLE INITIALLY DEFERRED,
 Country VARCHAR(4) ,
 Province VARCHAR(35) ,
 CONSTRAINT GRiverKey PRIMARY KEY (Province ,Country, River),
 CONSTRAINT Province_FKey FOREIGN KEY (Province, Country)
   REFERENCES Province(Name, Country) DEFERRABLE INITIALLY DEFERRED);

CREATE TABLE geo_Sea
(Sea VARCHAR(35)
   REFERENCES Sea DEFERRABLE INITIALLY DEFERRED,
 Country VARCHAR(4)  ,
 Province VARCHAR(35) ,
 CONSTRAINT GSeaKey PRIMARY KEY (Province, Country, Sea),
 CONSTRAINT Province_FKey FOREIGN KEY (Province, Country)
   REFERENCES Province(Name, Country) DEFERRABLE INITIALLY DEFERRED);

CREATE TABLE geo_Lake
(Lake VARCHAR(35)
   REFERENCES Lake DEFERRABLE INITIALLY DEFERRED,
 Country VARCHAR(4) ,
 Province VARCHAR(35) ,
 CONSTRAINT GLakeKey PRIMARY KEY (Province, Country, Lake),
 CONSTRAINT Province_FKey FOREIGN KEY (Province, Country)
   REFERENCES Province(Name, Country) DEFERRABLE INITIALLY DEFERRED);

CREATE TABLE geo_Source
(River VARCHAR(35)
   REFERENCES River DEFERRABLE INITIALLY DEFERRED,
 Country VARCHAR(4) ,
 Province VARCHAR(35) ,
 CONSTRAINT GSourceKey PRIMARY KEY (Province, Country, River),
 CONSTRAINT Province_FKey FOREIGN KEY (Province, Country)
   REFERENCES Province(Name, Country) DEFERRABLE INITIALLY DEFERRED);

CREATE TABLE geo_Estuary
(River VARCHAR(35)
   REFERENCES River DEFERRABLE INITIALLY DEFERRED,
 Country VARCHAR(4) ,
 Province VARCHAR(35) ,
 CONSTRAINT GEstuaryKey PRIMARY KEY (Province, Country, River),
 CONSTRAINT Province_FKey FOREIGN KEY (Province, Country)
   REFERENCES Province(Name, Country) DEFERRABLE INITIALLY DEFERRED);

CREATE TABLE mergesWith
(Sea1 VARCHAR(35)
   REFERENCES Sea DEFERRABLE INITIALLY DEFERRED,
 Sea2 VARCHAR(35)
   REFERENCES Sea DEFERRABLE INITIALLY DEFERRED,
 CONSTRAINT MergesWithKey PRIMARY KEY (Sea1, Sea2) );

CREATE TABLE located
(City VARCHAR(35) ,
 Province VARCHAR(35) ,
 Country VARCHAR(4) ,
 River VARCHAR(35)
   REFERENCES River DEFERRABLE INITIALLY DEFERRED,
 Lake VARCHAR(35)
   REFERENCES Lake DEFERRABLE INITIALLY DEFERRED,
 Sea VARCHAR(35)
   REFERENCES Sea DEFERRABLE INITIALLY DEFERRED,
 CONSTRAINT City_FKey FOREIGN KEY (City, Country, Province)
   REFERENCES City(Name, Country, Province) DEFERRABLE INITIALLY DEFERRED,
 CONSTRAINT located_U_River UNIQUE (City, Country, Province, River),
 CONSTRAINT located_U_Lake UNIQUE (City, Country, Province, Lake),
 CONSTRAINT located_U_Sea UNIQUE (City, Country, Province, Sea));

CREATE TABLE locatedOn
(City VARCHAR(35) ,
 Province VARCHAR(35) ,
 Country VARCHAR(4) ,
 Island VARCHAR(35)
   REFERENCES Island DEFERRABLE INITIALLY DEFERRED,
 CONSTRAINT locatedOnKey PRIMARY KEY (City, Province, Country, Island),
 CONSTRAINT City_FKey FOREIGN KEY (City, Country, Province)
   REFERENCES City(Name, Country, Province) DEFERRABLE INITIALLY DEFERRED);

CREATE TABLE islandIn
(Island VARCHAR(35)
   REFERENCES Island DEFERRABLE INITIALLY DEFERRED,
 Sea VARCHAR(35)
   REFERENCES Sea DEFERRABLE INITIALLY DEFERRED,
 Lake VARCHAR(35)
   REFERENCES Lake DEFERRABLE INITIALLY DEFERRED,
 River VARCHAR(35)
   REFERENCES River DEFERRABLE INITIALLY DEFERRED,
 CONSTRAINT islandIn_U_Sea UNIQUE (Island, Sea),
 CONSTRAINT islandIn_U_Lake UNIQUE (Island, Lake),
 CONSTRAINT islandIn_U_River UNIQUE (Island, River));

CREATE TABLE MountainOnIsland
(Mountain VARCHAR(35)
   REFERENCES Mountain DEFERRABLE INITIALLY DEFERRED,
 Island  VARCHAR(35)
   REFERENCES Island DEFERRABLE INITIALLY DEFERRED,
 CONSTRAINT MntIslKey PRIMARY KEY (Mountain, Island) );

CREATE VIEW symmetric_borders(Country1, Country2, length) AS
SELECT Country1, Country2, Length
FROM borders
UNION
SELECT Country2, Country1, Length
FROM borders;

CREATE VIEW symmetric_mergesWith(Sea1, Sea2) AS
SELECT Sea1, Sea2
FROM mergesWith
UNION
SELECT Sea2, Sea1
FROM mergesWith;
