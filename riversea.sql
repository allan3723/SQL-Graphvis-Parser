SELECT distinct River.Name
FROM river_to_sea, River
WHERE river_to_sea.River = River.Name;

SELECT distinct Sea.Name
FROM river_to_sea, Sea
WHERE river_to_sea.River = Sea.Name;