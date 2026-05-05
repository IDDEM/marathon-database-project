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