SELECT distinct River.Name
FROM river_to_sea, River
WHERE river_to_sea.River = River.Name;