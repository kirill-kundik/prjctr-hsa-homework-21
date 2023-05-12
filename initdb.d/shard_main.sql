CREATE EXTENSION postgres_fdw;

CREATE SERVER shard_2_server
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'postgres-shard1', port '5432', dbname 'shard_db');

CREATE SERVER shard_3_server
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'postgres-shard2', port '5432', dbname 'shard_db');

CREATE USER MAPPING FOR shard_user
    SERVER shard_2_server
    OPTIONS (user 'shard_user', password 'shard_pass');

CREATE USER MAPPING FOR shard_user
    SERVER shard_3_server
    OPTIONS (user 'shard_user', password 'shard_pass');

CREATE TABLE IF NOT EXISTS measurements
(
    city_id   INT  NOT NULL,
    logdate   DATE NOT NULL,
    peaktemp  INT  NOT NULL,
    unitsales INT  NOT NULL
) PARTITION BY RANGE (logdate);

CREATE INDEX idx_measurements_logdate ON measurements (logdate);

CREATE TABLE measurements_2023 PARTITION OF measurements
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE measurements_2010_2020 PARTITION OF measurements
    FOR VALUES FROM ('2010-01-01') TO ('2021-01-01');

CREATE TABLE measurements_default PARTITION OF measurements
    DEFAULT;

CREATE FOREIGN TABLE measurements_2022
    PARTITION OF measurements
        FOR VALUES FROM ('2022-01-01') TO ('2023-01-01')
    SERVER shard_2_server OPTIONS (table_name 'measurements');

CREATE FOREIGN TABLE measurements_2021
    PARTITION OF measurements
        FOR VALUES FROM ('2021-01-01') TO ('2022-01-01')
    SERVER shard_3_server OPTIONS (table_name 'measurements');
