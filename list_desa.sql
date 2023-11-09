WITH List AS (
    SELECT
        provinsi,
        kabupaten,
        COUNT(desa) AS "#desa",
        ROW_NUMBER() OVER (PARTITION BY provinsi ORDER BY COUNT(*) DESC) AS urutan
    FROM list_desa
    GROUP BY provinsi, kabupaten
)
SELECT provinsi, kabupaten, urutan, "#desa"
FROM List
WHERE urutan <= 5
ORDER BY provinsi ASC, urutan ASC;
WITH t AS (
  SELECT
    provinsi,
    kabupaten,
    "#desa",
    ROW_NUMBER() OVER (PARTITION BY provinsi ORDER BY "#desa"DESC) AS urutan
  FROM (
    SELECT
      provinsi,
      kabupaten,
      COUNT(desa) AS "#desa"
    FROM list_desa
    GROUP BY provinsi, kabupaten
  ) ranked
)
SELECT
  provinsi,
  kabupaten,
  urutan,
  "#desa"
FROM t
WHERE urutan <= 5
ORDER BY provinsi, urutan;