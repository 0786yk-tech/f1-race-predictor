-- Driver season summary: qualifying vs race performance
SELECT 
    d.driver_name,
    COUNT(*) AS races_entered,
    AVG(r.grid_position) AS avg_grid,
    AVG(r.finish_position) AS avg_finish,
    SUM(r.points) AS total_points
FROM results r
JOIN drivers d ON r.driver_id = d.driver_id
GROUP BY d.driver_name
ORDER BY total_points DESC;
