EXPLAIN
(ANALYZE, FORMAT YAML)
SELECT d, count(id)
FROM dim_time
    LEFT JOIN fact_charts ON created_at<=d AND d<deleted_at
GROUP BY 1
ORDER BY 1;