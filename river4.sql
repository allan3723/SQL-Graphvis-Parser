SELECT distinct Name
FROM river_to_river, River
WHERE Name = River1
OR Name = River2
UNION
SELECT distinct River.Name
FROM river_to_lake, River
WHERE river_to_lake.River = River.Name;