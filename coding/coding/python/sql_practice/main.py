import sqlite3


# Creates the db if it doesn't exist
connection = sqlite3.connect("database.db")

# Cursor is in charge of executing SQL queries/cmds
cursor = connection.cursor()

# string = TEXT, float = REAL, int = INTEGER, binary = BLOB
cursor.execute("CREATE TABLE students (name TEXT, age INTEGER, score INTEGER)")

# List of tuples containing the table information to be stored
students = [
    ("Greg", 14, 98),
    ("Tom", 13, 77),
    ("Ed", 14, 81),
    ("Lisa", 14, 92),
    ("Jen", 15, 66),
]

# Since it's not just 1 item being inserted, we need to use `insertmany()`
cursor.executemany("INSERT INTO students VALUES (?,?,?)", students)

# Grab all the items in table `students`
for row in cursor.execute('SELECT * FROM students'):
    print(row)

# Must close the connection at the end.
connection.close()
