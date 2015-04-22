SELECT distinct Sea.Name
FROM river_to_sea, Sea
WHERE river_to_sea.River = Sea.Name;