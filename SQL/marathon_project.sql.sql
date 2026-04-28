DROP DATABASE IF EXISTS marathon_db;
CREATE DATABASE marathon_db;
USE marathon_db;

DROP TABLE IF EXISTS Incident;
DROP TABLE IF EXISTS RunnerCheckpoint;
DROP TABLE IF EXISTS Checkpoint;
DROP TABLE IF EXISTS Runner;
DROP TABLE IF EXISTS Marathon;
DROP TABLE IF EXISTS Category;

-- TABLES

CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    age_group VARCHAR(20) NOT NULL,
    gender VARCHAR(10) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE Runner (
    runner_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    birth_year INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
) ENGINE=InnoDB;

CREATE TABLE Marathon (
    marathon_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date DATE NOT NULL,
    location VARCHAR(100),
    total_distance_km DECIMAL(5,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE Checkpoint (
    checkpoint_id INT AUTO_INCREMENT PRIMARY KEY,
    marathon_id INT NOT NULL,
    distance_km DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (marathon_id) REFERENCES Marathon(marathon_id)
) ENGINE=InnoDB;

CREATE TABLE RunnerCheckpoint (
    runner_id INT,
    checkpoint_id INT,
    time_seconds INT NOT NULL,
    pace DECIMAL(5,2),
    PRIMARY KEY (runner_id, checkpoint_id),
    FOREIGN KEY (runner_id) REFERENCES Runner(runner_id),
    FOREIGN KEY (checkpoint_id) REFERENCES Checkpoint(checkpoint_id)
) ENGINE=InnoDB;

CREATE TABLE Incident (
    incident_id INT AUTO_INCREMENT PRIMARY KEY,
    runner_id INT NOT NULL,
    marathon_id INT NOT NULL,
    checkpoint_id INT,
    type VARCHAR(50) NOT NULL,
    description TEXT,
    FOREIGN KEY (runner_id) REFERENCES Runner(runner_id),
    FOREIGN KEY (marathon_id) REFERENCES Marathon(marathon_id),
    FOREIGN KEY (checkpoint_id) REFERENCES Checkpoint(checkpoint_id)
) ENGINE=InnoDB;

-- TRIGGER (created before inserts so pace is auto-calculated)

DROP TRIGGER IF EXISTS before_insert_runnercheckpoint;
DELIMITER $$

CREATE TRIGGER before_insert_runnercheckpoint
BEFORE INSERT ON RunnerCheckpoint
FOR EACH ROW
BEGIN
    DECLARE checkpoint_distance DECIMAL(5,2);

    SELECT distance_km
    INTO checkpoint_distance
    FROM Checkpoint
    WHERE checkpoint_id = NEW.checkpoint_id;

    SET NEW.pace = NEW.time_seconds / 60 / checkpoint_distance;
END$$

DELIMITER ;

-- FUNCTION

DROP FUNCTION IF EXISTS get_runner_total_time;
DELIMITER $$

CREATE FUNCTION get_runner_total_time(p_runner_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_time INT;

    SELECT MAX(rc.time_seconds)
    INTO total_time
    FROM RunnerCheckpoint rc
    WHERE rc.runner_id = p_runner_id;

    RETURN total_time;
END$$

DELIMITER ;

-- PROCEDURE

DROP PROCEDURE IF EXISTS GetLeaderboard;
DELIMITER $$

CREATE PROCEDURE GetLeaderboard()
BEGIN
    SELECT
        r.runner_id,
        r.name,
        c.age_group,
        c.gender,
        MAX(rc.time_seconds) AS total_time_seconds
    FROM Runner r
    JOIN Category c ON r.category_id = c.category_id
    JOIN RunnerCheckpoint rc ON r.runner_id = rc.runner_id
    GROUP BY r.runner_id, r.name, c.age_group, c.gender
    ORDER BY total_time_seconds ASC;
END$$

DELIMITER ;

-- DATA

INSERT INTO Category (age_group, gender)
VALUES
('18-29', 'Male'),
('18-29', 'Female'),
('30-39', 'Male'),
('30-39', 'Female');

INSERT INTO Runner (name, birth_year, gender, category_id)
VALUES
('Nader Salah', 2002, 'Male', 1),
('Haifa Al Huthiily', 1998, 'Female', 2),
('Aymen Idris', 1987, 'Male', 3),
('Razan Ghuraibi', 1992, 'Female', 4);

INSERT INTO Marathon (name, date, location, total_distance_km)
VALUES ('Riyadh Marathon', '2025-06-01', 'Riyadh', 42.2);

INSERT INTO Checkpoint (marathon_id, distance_km)
VALUES
(1, 5),
(1, 10),
(1, 21.1),
(1, 30),
(1, 42.2);

-- Pace is auto-calculated by the trigger
INSERT INTO RunnerCheckpoint (runner_id, checkpoint_id, time_seconds)
VALUES
(1, 1, 1500),
(1, 2, 3000),
(1, 3, 6300),
(1, 4, 9000),
(2, 1, 1600),
(2, 2, 3300),
(2, 3, 7000);

INSERT INTO Incident (runner_id, marathon_id, checkpoint_id, type, description)
VALUES
(2, 1, 3, 'dropout', 'Runner stopped due to exhaustion');

-- QUERIES

-- Query 1: Average pace per checkpoint (JOIN + GROUP BY + AVG)
SELECT
    c.distance_km,
    ROUND(AVG(rc.pace), 2) AS average_pace
FROM Checkpoint c
LEFT JOIN RunnerCheckpoint rc
    ON c.checkpoint_id = rc.checkpoint_id
GROUP BY c.checkpoint_id, c.distance_km
ORDER BY c.distance_km;

-- Query 2: Total time per runner (JOIN + GROUP BY + MAX)
SELECT
    r.runner_id,
    r.name,
    MAX(rc.time_seconds) AS total_time_seconds
FROM Runner r
LEFT JOIN RunnerCheckpoint rc
    ON r.runner_id = rc.runner_id
GROUP BY r.runner_id, r.name
ORDER BY total_time_seconds ASC;

-- Query 3: Finish rate per category (JOIN + subquery + COUNT + GROUP BY)
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

-- Query 4: Dropout count per checkpoint (JOIN + COUNT + GROUP BY)
SELECT
    cp.distance_km,
    COUNT(i.incident_id) AS dropout_count
FROM Checkpoint cp
LEFT JOIN Incident i
    ON cp.checkpoint_id = i.checkpoint_id
    AND i.type = 'dropout'
GROUP BY cp.checkpoint_id, cp.distance_km
ORDER BY cp.distance_km;

-- Query 5: Leaderboard per category (3-table JOIN + GROUP BY + MAX)
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