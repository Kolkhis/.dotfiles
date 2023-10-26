import sqlite3


# Creates the db if it doesn't exist
connection = sqlite3.connect("database.db")

# Cursor is in charge of executing SQL queries/cmds
cursor = connection.cursor()

# string = TEXT, float = REAL, int = INTEGER, binary = BLOB
cursor.execute("CREATE TABLE students (name TEXT, age INTEGER, score INTEGER)")

# List of tuples containing the table information to be stored
students = [
    ("Greg Walsh", 14, 98),
    ("Tom Riddle", 13, 77),
    ("Eduardo Marinez", 14, 81),
    ("Misa Misa", 14, 92),
    ("Yennifer of Vengeburg", 15, 66),
]



students_in_dicts = [
    {"name": "Greg Walsh", "age": 14, "score": 98},
    {"name": "Tom Riddle", "age": 13, "score": 77},
    {"name": "Eduardo Martinez", "age": 14, "score": 81},
    {"name": "Misa Misa", "age": 14, "score": 92},
    {"name": "Yennifer of Vengeburg", "age": 15, "score": 66},
]

# Since it's not just 1 item being inserted, we need to use `insertmany()`
cursor.executemany("INSERT INTO students VALUES (?,?,?)", students)

# Grab all the items in table `students`
for row in cursor.execute("SELECT * FROM students"):
    print(row)

yen = cursor.execute('SELECT * FROM students WHERE name LIKE "Yen%"')
print(yen)


# Must close the connection at the end.
connection.close()
