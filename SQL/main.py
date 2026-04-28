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

    print("\n--- Dropout Count by Checkpoint ---")
    for distance, count in rows:
        print(f"{float(distance)} km : {count} dropouts")


def show_runner_total_time(cursor):
    runner_id = input("Enter runner ID: ").strip()

    if not runner_id.isdigit():
        print("Please enter a valid numeric runner ID.")
        return

    query = "SELECT get_runner_total_time(%s);"
    cursor.execute(query, (int(runner_id),))
    row = cursor.fetchone()

    print("\n--- Runner Total Time ---")
    print(f"Runner ID {runner_id}: {row[0]}")

def show_leaderboard(cursor):
    print("\n--- Leaderboard ---")

    cursor.callproc("GetLeaderboard")

    found = False
    for result in cursor.stored_results():
        found = True
        rows = result.fetchall()

        for runner_id, name, age_group, gender, total_time in rows:
            print(f"ID: {runner_id} | {name} | {age_group} {gender} | Time: {total_time}")

    if not found:
        print("No leaderboard data found.")


def main():
    try:
        db = connect_db()
        cursor = db.cursor()

        while True:
            print("\n===== Marathon Database Menu =====")
            print("1. Show all runners")
            print("2. Show average pace per checkpoint")
            print("3. Show finish rate by category")
            print("4. Show dropout count by checkpoint")
            print("5. Show runner total time (function)")
            print("6. Show leaderboard (procedure)")
            print("7. Exit")

            choice = input("Choose an option: ")

            if choice == "1":
                show_runners(cursor)
            elif choice == "2":
                show_average_pace(cursor)
            elif choice == "3":
                show_finish_rate(cursor)
            elif choice == "4":
                show_dropouts(cursor)
            elif choice == "5":
                show_runner_total_time(cursor)
            elif choice == "6":
                show_leaderboard(cursor)
            elif choice == "7":
                print("Exiting program.")
                break
            else:
                print("Invalid choice. Try again.")

        cursor.close()
        db.close()

    except mysql.connector.Error as err:
        print("Database error:", err)


if __name__ == "__main__":
    main()