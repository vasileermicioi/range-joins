EXPLAIN
(ANALYZE, FORMAT YAML)
SELECT dim_time.d, SUM(SUM(daily_charts.n)) OVER (ORDER BY dim_time.d)
FROM dim_time
    LEFT JOIN (
	        SELECT created_at d, COUNT(1) n
        FROM fact_charts
        GROUP BY 1
    UNION ALL
        SELECT deleted_at d, -COUNT(1) n
        FROM fact_charts
        GROUP BY 1
) daily_charts ON dim_time.d = daily_charts.d
GROUP BY 1
ORDER BY 1;
