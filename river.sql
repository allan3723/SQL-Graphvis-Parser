SELECT distinct Name
FROM river_to_river, River
WHERE Name = River1
OR Name = River2;