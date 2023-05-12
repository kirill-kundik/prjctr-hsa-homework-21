-- Query for inserting 10M random rows into the test table
EXPLAIN ANALYSE
INSERT INTO measurements
SELECT random_int_between(1, 1000000)                              AS city_id,
       random_date_between('2020-01-01'::DATE, '2023-07-01'::DATE) AS logdate,
       random_int_between(1, 1000000)                              AS peaktemp,
       random_int_between(1, 1000000)                              AS unitsales
FROM generate_series(1, 10000000);


-- Query for selecting all rows from the test table
EXPLAIN ANALYSE
SELECT *
FROM measurements;

-- Query for selecting all rows from the test table in specified range
EXPLAIN ANALYSE
SELECT *
FROM measurements
WHERE logdate > '2021-10-10'::DATE
  AND logdate < '2021-12-10'::DATE;
