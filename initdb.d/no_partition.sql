CREATE TABLE IF NOT EXISTS measurements
(
    city_id   INT  NOT NULL,
    logdate   DATE NOT NULL,
    peaktemp  INT  NOT NULL,
    unitsales INT  NOT NULL
);

CREATE INDEX idx_measurements_logdate ON measurements (logdate);
