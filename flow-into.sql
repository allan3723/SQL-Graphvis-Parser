CREATE OR REPLACE VIEW river_to_river(River1, River2) AS
SELECT name, river
FROM RIVER
WHERE river IS NOT NULL;

CREATE OR REPLACE VIEW river_to_sea(River, Sea) AS
SELECT name, sea
FROM RIVER
WHERE sea IS NOT NULL;

CREATE OR REPLACE VIEW river_to_lake(River, Lake) AS
SELECT name, lake
FROM RIVER
WHERE lake IS NOT NULL;
