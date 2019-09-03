CREATE TABLE dim_time
(
	d int4 NOT NULL,
	CONSTRAINT dim_time_pk PRIMARY KEY (d)
);

CREATE TABLE fact_charts
(
	id int4 NOT NULL,
	created_at int4 NULL,
	deleted_at int4 NULL,
	CONSTRAINT fact_charts_pk PRIMARY KEY (id)
);
CREATE INDEX fact_charts_range_idx ON rangedb.fact_charts USING btree
(created_at, deleted_at);