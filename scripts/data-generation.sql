-- helper function
CREATE OR REPLACE FUNCTION myrandom(low NUMERIC, high NUMERIC, seed NUMERIC = 1) 
RETURNS NUMERIC AS
$$
BEGIN
    RETURN (ABS(HASHTEXT(seed::TEXT)) % (high-low + 1) + low);
END;
$$ LANGUAGE 'plpgsql' STRICT;

-- generate data
CREATE OR REPLACE PROCEDURE generate_range_data(nTime NUMERIC, nCharts NUMERIC, avgRange NUMERIC)
LANGUAGE 'plpgsql'
AS $$
BEGIN
    -- dim_time rows
    TRUNCATE dim_time;

	INSERT INTO dim_time(d)
	SELECT generate_series(1, nTime);
	
	-- fact_items rows
	TRUNCATE fact_charts;
	
	INSERT INTO fact_charts
	SELECT
	    i AS id,
	    myrandom(1, nTime, i) AS created_at,
	    myrandom(1, nTime, i) + myrandom(1, 2 * avgRange, i * i) AS deleted_at
	FROM generate_series(1, nCharts) i;
END;
$$;