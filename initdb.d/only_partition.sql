CREATE TABLE IF NOT EXISTS measurements
(
    city_id   INT  NOT NULL,
    logdate   DATE NOT NULL,
    peaktemp  INT  NOT NULL,
    unitsales INT  NOT NULL
) PARTITION BY RANGE (logdate);

CREATE INDEX idx_measurements_logdate ON measurements (logdate);

CREATE TABLE measurements_2022 PARTITION OF measurements
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE measurements_2023 PARTITION OF measurements
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE measurements_default PARTITION OF measurements
    DEFAULT;
