idde
idris.m10_78383
Do Not Disturb

Samra.Shahoud — 02:20
docker exec itsec-mariadb mariadb -uroot -pexample itsec -e 'UPDATE User SET userPassword="$2a$10$AQA.hX1ancepTqnKnoVkDeSpHKBiU4ictehUDe.2JjzeVK0ha4FLe", userRole=1, userFirstName="Admin", userSurName="Adminson" WHERE userMail="admin@admin.com";'
# Eshop-JS — kmom10 (itsec, Samra)

Min inlämning för kmom10 i kursen *Informationssäkerhet med
webbtillämpningar* (DV1616). Applikationen är en Express/Node.js-baserad
e-handel med MariaDB som databas. Inlämningen omfattar samtliga tre krav:

message.txt
14 KB
idde — 14:38
import mysql.connector


def connect_db():
    return mysql.connector.connect(
        host="127.0.0.1",

app.py
6 KB


DROP DATABASE IF EXISTS marathon_db;
CREATE DATABASE marathon_db;
USE marathon_db;

marathon_project.sql.sql
7 KB
Project Marathon Performance and Progress Tracking System

# Project Description
This project aims to develop a database system to analyze the performance of marathon runners.  

The database will contain information about the runners, the marathon checkpoints, the pace of the runners at different checkpoints, as well as any incident that may have occurred during the marathon.  

README.md
2 KB
# Marathon Race Tracking Database System

**Student:** Mohammed Idris - moid25@student.bth.se

## 1. Project Idea

marathon_race_tracking.md
11 KB
idde — 14:45
NOT OK.

You have no name in your report. Did you check the template file?

That is not an ER. You are doing the thing I explicitly mentioned several times during the lectures to not do: mix ER notations.

Task 2, please underscore the primary keys or use PK / FK marks when listing entity sets and attributes. 

No screenshots for queries, please!

You say you have trigger but it is not listed in the report. 

Your function has another query on top? Why? How is that used in the code?

You have no discussion at all. A simple short one should suffice.
Database
Project Description
Contact person: Ilir Jusufi: ilir.jusufi@bth.se
Birgitta Hermanson: birgitta.hermanson@bth.se
This is a final project specification. You are responsible to come up with an interesting
problem that can be solved with a database and programming. It is important that you find a
reasonable scope for your project. You can use whatever interface you like, either multiple
programs, and console UI, a web interface, or whatever else you like. All answers should be
your own. You are allowed to work in groups of two. Make sure you include your names in
the report when you submit.
Tasks
1.Idea
Come up with an idea for your project. Describe what problem it solves, who the main
user(s) will be, and why your idea is a good fit for them and the problem. Describe the main
features that your application must have to be complete including the source of the data. You
can collect real data for this, or use any appropriate data generator to populate your
database.
Optional deadline task: You can submit your idea, one page maximum, as an intermediate
step to get feedback about the scope of your project. We will primarily give you hints about if
your project is “large” or “complex” enough to get a passing grade.
2. Logical model
Design a data model for your project and present it as an E/R diagram. Make sure to include
important attributes and relationships. Discuss and motivate your design.
3. Translate the Design to SQL schema
Translate your design to collections in SQL. Discuss and motivate how you translated
entities and relationships.
4. SQL queries
Create at least five queries to your SQL design that are needed to implement the
functionality of your application. You will probably need to create more than five queries to
make your application functional, however we require some specific cases to be
implemented and described in the assignment report. Focus on the more important queries
and features of your application (i.e., there is no need to show how you insert documents in
your various collections). Explain and motivate each query.
General guidelines for queries:
1. At least two of the five queries should deal with data from more than one table, i.e.,
you should use at least two multirelation queries
2. You should make use of SQL JOIN
3. You should make use of Aggregation and/or Grouping
4. You should make use of at least two of the following:
a. Triggers
b. Procedures
c. Functions
5. Implementation
Write a program that implements your Idea in Task 1 with the design and queries from Task
2-4. You are of course allowed to introduce more queries. You should use Python for
implementation. You are free to use web based frameworks such as Flask. However, you are
not allowed to use Object Relational Mapping (ORM). You need to explicitly write your
queries.
Submission
Your submission should include solutions to all assignments above. Submit a report in PDF
format on Canvas. Please submit the source code and database dump at an accessible Git
or GitLab repository and include the link in your report. You can draw the E/R diagrams by
hand and submit scanned versions or photos (as long as they are readable). The report
should have at least 4 pages and should not be longer than 8 including Tables and Figures.
Finally, your report should have an appendix with the changelog to document who has done
what on the project. Check the report template for more information.
Oral presentation in Zoom
Each group has 20 minutes to present their work. The work must have been
submitted in Canvas and have been approved for reporting. Accounting times
allocated in the calendar in Canvas.
NOTE: Follow the submission and implementation guidelines carefully. If they do not
adhere to the requirements presented in this document you will get a failing grade!
LIST OF INVALID PROJECTS:
- Student registrations, students grades
- Booking (library, restaurants, hotels …)
- Book, Music, CD, Comic Books (simple catalogs with Genre etc.)

Final Project Report
Student(s): Ilir Jusufi – ilir.jusufi@bth.se
Maria Martins – mm@bth.se
1. Project Idea
Here you should discuss your idea. For instance:
For this assignment we have designed and implemented a system to store data about the
COVID vaccination. We have downloaded the data from this source: www.somesource.com
(alternatively you can generate your own data). Our tool enables users to track this data but
also provide various statistics and visualizations of the data. ….
2. Schema Design
Here you pr

message.txt
5 KB
Final Project Report
Student(s): Ilir Jusufi – ilir.jusufi@bth.se
Maria Martins – mm@bth.se
Project Idea
Here you should discuss your idea. For instance:
For this assignment we have designed and implemented a system to store data about the
COVID vaccination. We have downloaded the data from this source: www.somesource.com
(alternatively you can generate your own data). Our tool enables users to track this data but
also provide various statistics and visualizations of the data. ….
Schema Design
Here you present your schema design. You can use softwares such as
https://app.diagrams.net/ to draw your schema. Explain all the tables/relations and different
connections they have.
SQL Queries
Here you present and discuss the most interesting queries. Make sure you have 5 of them at
least and check the specification in the assignment sheet. One example is found below:
Q: List the name, last name and job title of the employee from a given city.
The following query is a multirelation query and uses JOIN. We pass the argument of the city
name (marked with ? in the query) and the query should give us all the employees of the
corresponding shop. We join table Employees on table Shops by matching the Shops.ID to
the foreign key
Employees.shopID
SELECT firstname, lastname, jobtitle
FROM Employees
JOIN Shops ON Employees.shopID = Shops.ID
WHERE city=?;
Discussion and Resources
Here you can write anything you might think it is important and provide the link to the
required resources. For example:
We had issues with the missing and inconsistent data. We decided to remove/insert NULLS
in the missing/corrupted attributes/tuples…...
The project uses xyz library, please check readme.txt for installation details.
Source code: [github/... link]
Video demonstration: [youtube/vimeo/... link]
Database
Project Description
Contact person: Ilir Jusufi: ilir.jusufi@bth.se
Birgitta Hermanson: birgitta.hermanson@bth.se
This is a final project specification. You are responsible to come up with an interesting
problem that can be solved with a database and programming. It is important that you find a

message.txt
4 KB
Samra.Shahoud — 15:25
import mysql.connector


import os

def connect_db():
    return mysql.connector.connect(
        host="127.0.0.1",
        port=3306,
        user="root",
        password=os.environ.get("DB_PASSWORD", ""),
        database="marathon_db"
    )


def show_runners(cursor):
    query = """
    SELECT runner_id, name, birth_year, gender
    FROM Runner
    ORDER BY runner_id;
    """
    cursor.execute(query)
    rows = cursor.fetchall()

    print("\n--- All Runners ---")
    for runner_id, name, birth_year, gender in rows:
        print(f"ID: {runner_id}, Name: {name}, Birth year: {birth_year}, Gender: {gender}")


def show_average_pace(cursor):
    query = """
    SELECT 
        c.distance_km,
        ROUND(AVG(rc.pace), 2) AS average_pace
    FROM Checkpoint c
    LEFT JOIN RunnerCheckpoint rc
        ON c.checkpoint_id = rc.checkpoint_id
    GROUP BY c.checkpoint_id, c.distance_km
    ORDER BY c.distance_km;
    """
    cursor.execute(query)
    rows = cursor.fetchall()

    print("\n--- Average Pace per Checkpoint ---")
    for distance, pace in rows:
        if pace is None:
            print(f"{float(distance)} km : no pace data")
        else:
            print(f"{float(distance)} km : {pace} min/km")


def show_finish_rate(cursor):
    query = """
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
    """

    cursor.execute(query)
    rows = cursor.fetchall()

    print("\n--- Finish Rate by Category ---")

    for age_group, gender, total, finishers, rate in rows:
        print(f"{age_group} {gender} | Runners: {total} | Finishers: {finishers} | Finish rate: {rate}%")


def show_dropouts(cursor):
    query = """
    SELECT 
        cp.distance_km,
        COUNT(i.incident_id) AS dropout_count
    FROM Checkpoint cp
    LEFT JOIN Incident i 
        ON cp.checkpoint_id = i.checkpoint_id
        AND i.type = 'dropout'
    GROUP BY cp.checkpoint_id, cp.distance_km
    ORDER BY cp.distance_km;
    """
    cursor.execute(query)
    rows = cursor.fetchall()

... (80 lines left)

message.txt
6 KB

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
... (143 lines left)

message.txt
7 KB
import mysql.connector


def connect_db():
    return mysql.connector.connect(
        host="127.0.0.1",

message.txt
6 KB
mysql -u root -pKer222ker222 < marathon_project.sql.sql
DB_PASSWORD=Ker222ker222 python3 app.py
idde — 15:29
PS Microsoft.PowerShell.Core\FileSystem::\wsl.localhost\Ubuntu\home\idris\databas> mysql -u root -pKer222ker222 < marathon_project.sql.sql
At line:1 char:30
+ mysql -u root -pKer222ker222 < marathon_project.sql.sql
+                              ~
The '<' operator is reserved for future use.
    + CategoryInfo          : ParserError: (:) [], ParentContainsErrorRecordException
    + FullyQualifiedErrorId : RedirectionNotSupported
Samra.Shahoud — 15:30
Get-Content marathon_project.sql.sql | mysql -u root -pKer222ker222
$env:DB_PASSWORD="Ker222ker222"; python3 app.py
idde — 15:30
PS Microsoft.PowerShell.Core\FileSystem::\wsl.localhost\Ubuntu\home\idris\databas> Get-Content marathon_project.sql.sql | mysql -u root -pKer222ker222
mysql : The term 'mysql' is not recognized as the name of a cmdlet, function, script file, or operable 
program. Check the spelling of the name, or if a path was included, verify that the path is correct 
and try again.
At line:1 char:40
+ Get-Content marathon_project.sql.sql | mysql -u root -pKer222ker222
+                                        ~
    + CategoryInfo          : ObjectNotFound: (mysql:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
Samra.Shahoud — 15:31
mysql -u root -pKer222ker222 < marathon_project.sql.sql
DB_PASSWORD=Ker222ker222 python3 app.py
idde — 15:31
idris@idris:~/databas$ mysql -u root -pKer222ker222 < marathon_project.sql.sql
DB_PASSWORD=Ker222ker222 python3 app.py
-bash: marathon_project.sql.sql: No such file or directory
python3: can't open file '/home/idris/databas/app.py': [Errno 2] No such file or directory
idris@idris:~/databas$
Samra.Shahoud — 15:31
mysql -u root -pKer222ker222 < marathon_project.sql.sql
idde — 15:33
idris@idris:~/databas/SQL$ mysql -u root -pKer222ker222 < marathon_project.sql.sql
mysql: [Warning] Using a password on the command line interface can be insecure.
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)
idris@idris:~/databas/SQL$
idris@idris:~/databas/SQL$ mysql -u root -pKer222ker222 < marathon_project.sql.sql
mysql: [Warning] Using a password on the command line interface can be insecure.
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)
idris@idris:~/databas/SQL$ sudo service mysql start
Failed to start mysql.service: Unit mysql.service not found.
idris@idris:~/databas/SQL$ sudo install mysql
install: missing destination file operand after 'mysql'
Try 'install --help' for more information.
idris@idris:~/databas/SQL$
Samra.Shahoud — 15:34
sudo apt update && sudo apt install -y mysql-server
sudo service mysql start
mysql -u root -pKer222ker222 < marathon_project.sql.sql
idde — 15:36
idris@idris:~/databas/SQL$ mysql -u root -pKer222ker222 < marathon_project.sql.sql
mysql: [Warning] Using a password on the command line interface can be insecure.
ERROR 1698 (28000): Access denied for user 'root'@'localhost'
idris@idris:~/databas/SQL$
Samra.Shahoud — 15:36
import mysql.connector


import os

def connect_db():

message.txt
6 KB
idde — 15:37
idris@idris:~/databas/SQL$ mysql -u root -pKer222ker222 < marathon_project.sql.sql
mysql: [Warning] Using a password on the command line interface can be insecure.
ERROR 1698 (28000): Access denied for user 'root'@'localhost'
idris@idris:~/databas/SQL$ mysql -u root -pKer222ker222 < marathon_project.sql.sql
mysql: [Warning] Using a password on the command line interface can be insecure.
ERROR 1698 (28000): Access denied for user 'root'@'localhost'
idris@idris:~/databas/SQL$
Samra.Shahoud — 15:37
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Ker222ker222';
FLUSH PRIVILEGES;
EXIT;
mysql -u root -pKer222ker222 < marathon_project.sql.sql
idde — 15:46
https://github.com/IDDEM/marathon-database-project
GitHub
GitHub - IDDEM/marathon-database-project
Contribute to IDDEM/marathon-database-project development by creating an account on GitHub.
Project Marathon Performance and Progress Tracking System

# Project Description
This project aims to develop a database system to analyze the performance of marathon runners.  

The database will contain information about the runners, the marathon checkpoints, the pace of the runners at different checkpoints, as well as any incident that may have occurred during the marathon.  

README.md
2 KB
Samra.Shahoud — 15:50
# Marathon Performance and Progress Tracking System

## Project Description
A database system to analyze the performance of marathon runners. The database stores information about runners, marathon checkpoints, pace at different checkpoints, and incidents that occurred during the marathon.

## Technologies Used
- Python
- MySQL
- mysql-connector-python

## Database Structure
- **Category** – Runner categories (age group, gender)
- **Runner** – Runner information
- **Marathon** – Marathon event details
- **Checkpoint** – Distance checkpoints for a marathon
- **RunnerCheckpoint** – Runner times and pace at each checkpoint
- **Incident** – Dropouts or medical issues

## Features
1. Display all runners
2. Display average pace per checkpoint
3. Display finish rate by category
4. Display dropout count per checkpoint
5. Calculate total time for a runner (stored function)
6. Display leaderboard (stored procedure)

## How to Run

### 1. Start MySQL and import the database
bash
mysql -u root -p < marathon_project.sql.sql
### 2. Run the application
bash
DB_PASSWORD=yourpassword python3 app.py
Replace `yourpassword` with your MySQL root password.
idde — 15:53
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: store_management
-- ------------------------------------------------------
-- Server version	8.0.31

message.txt
11 KB
import mysql.connector

def connect_db():
    return mysql.connector.connect(
        host="127.0.0.1",
        user="root",

message.txt
10 KB
Samra.Shahoud — 15:55
mysql -u root -pKer222ker222 < marathon_project.sql.sql
mysqldump -u root -pKer222ker222 --routines --triggers marathon_db > dump.sql
-- Query 1: Average pace per checkpoint
-- Uses JOIN and GROUP BY with AVG aggregation
SELECT
    c.distance_km,
    ROUND(AVG(rc.pace), 2) AS average_pace
FROM Checkpoint c

message.txt
3 KB
﻿
Samra.Shahoud
s.s_2023
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