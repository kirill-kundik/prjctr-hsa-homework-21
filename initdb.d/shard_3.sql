CREATE TABLE IF NOT EXISTS measurements
(
    city_id INT NOT NULL,
    logdate DATE NOT NULL,
    peaktemp INT NOT NULL,
    unitsales INT NOT NULL,
    CONSTRAINT logdate_check CHECK (logdate >= DATE '2021-01-01' AND logdate < DATE '2022-01-01')
) PARTITION BY RANGE (logdate);

CREATE INDEX idx_measurements_logdate ON measurements (logdate);

CREATE TABLE measurements_1 PARTITION OF measurements
FOR VALUES FROM ('2021-01-01') TO ('2021-07-01');

CREATE TABLE measurements_2 PARTITION OF measurements
FOR VALUES FROM ('2021-07-01') TO ('2022-01-01');
