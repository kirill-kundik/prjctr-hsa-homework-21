CREATE OR REPLACE FUNCTION random_int_between(low INT, high INT)
    RETURNS INT AS
$$
BEGIN
    RETURN floor(random() * (high - low + 1) + low);
END;
$$ LANGUAGE 'plpgsql' STRICT;

CREATE OR REPLACE FUNCTION random_date_between(low DATE, high DATE)
    RETURNS DATE AS
$$
BEGIN
    RETURN low + trunc(random() * (high - low + 1))::INT;
END;
$$ LANGUAGE 'plpgsql' STRICT;
