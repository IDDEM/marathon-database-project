-- Query 1: Average pace per checkpoint
-- Uses JOIN and GROUP BY with AVG aggregation
SELECT
    c.distance_km,
    ROUND(AVG(rc.pace), 2) AS average_pace
FROM Checkpoint c
LEFT JOIN RunnerCheckpoint rc
    ON c.checkpoint_id = rc.checkpoint_id
GROUP BY c.checkpoint_id, c.distance_km
ORDER BY c.distance_km;

-- Query 2: Total time per runner
-- Uses JOIN and GROUP BY with MAX aggregation
SELECT
    r.runner_id,
    r.name,
    MAX(rc.time_seconds) AS total_time_seconds
FROM Runner r
LEFT JOIN RunnerCheckpoint rc
    ON r.runner_id = rc.runner_id
GROUP BY r.runner_id, r.name
ORDER BY total_time_seconds ASC;

-- Query 3: Finish rate per category
-- Uses JOIN, subquery, COUNT and GROUP BY
SELECT
    c.age_group,
    c.gender,
    COUNT(DISTINCT r.runner_id) AS total_runners,
    COUNT(DISTINCT rc.runner_id) AS finishers,
    ROUND(COUNT(DISTINCT rc.runner_id) * 100.0 / COUNT(DISTINCT r.runner_id), 2) AS finish_rate_percentage
FROM Runner r
JOIN Category c
    ON r.category_id = c.category_id
LEFT JOIN (
    SELECT DISTINCT rcp.runner_id
    FROM RunnerCheckpoint rcp
    JOIN Checkpoint cp
        ON rcp.checkpoint_id = cp.checkpoint_id
    WHERE cp.distance_km = (
        SELECT MAX(distance_km) FROM Checkpoint
    )
) rc
    ON r.runner_id = rc.runner_id
GROUP BY c.age_group, c.gender
ORDER BY c.age_group, c.gender;

-- Query 4: Dropout count per checkpoint
-- Uses JOIN, COUNT and GROUP BY
SELECT
    cp.distance_km,
    COUNT(i.incident_id) AS dropout_count
FROM Checkpoint cp
LEFT JOIN Incident i
    ON cp.checkpoint_id = i.checkpoint_id
    AND i.type = 'dropout'
GROUP BY cp.checkpoint_id, cp.distance_km
ORDER BY cp.distance_km;

-- Query 5: Leaderboard per category
-- Uses 3-table JOIN, MAX and GROUP BY
SELECT
    c.age_group,
    c.gender,
    r.name,
    MAX(rc.time_seconds) AS total_time
FROM Runner r
JOIN Category c
    ON r.category_id = c.category_id
LEFT JOIN RunnerCheckpoint rc
    ON r.runner_id = rc.runner_id
GROUP BY c.age_group, c.gender, r.runner_id, r.name
ORDER BY c.age_group, c.gender, total_time;

-- Stored Function: get_runner_total_time
-- Returns total race time for a given runner
SELECT get_runner_total_time(1) AS total_time;

-- Stored Procedure: GetLeaderboard
-- Returns full leaderboard sorted by time
CALL GetLeaderboard();
