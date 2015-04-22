SELECT DISTINCT River
FROM river_to_lake
UNION
SELECT DISTINCT River
FROM river_to_sea
WHERE River NOT IN(
  SELECT DISTINCT River
  FROM river_to_lake)
;