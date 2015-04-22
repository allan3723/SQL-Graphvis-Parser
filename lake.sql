SELECT distinct Lake.Name
FROM river_to_lake, Lake
WHERE river_to_lake.lake = Lake.Name;