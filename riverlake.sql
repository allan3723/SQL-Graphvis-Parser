SELECT distinct River.Name
FROM river_to_lake, River
WHERE river_to_lake.River = River.Name;

SELECT distinct Lake.Name
FROM river_to_lake, Lake
WHERE river_to_lake.River = Lake.Name;