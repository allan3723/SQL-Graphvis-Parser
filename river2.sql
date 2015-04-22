SELECT distinct River.Name
FROM river_to_lake, River
WHERE river_to_lake.River = River.Name;