import sqlite3


connection = sqlite3.connect("database.db")
cursor = connection.cursor()
# Cursor is in charge of executing SQL queries/cmds

cursor.execute("CREATE TABLE students (name TEXT, age INTEGER, score INTEGER)")
# string = TEXT, float = REAL, int = INTEGER, binary = BLOB

students = [
    ("Greg", 14, 98),
    ("Tom", 13, 77),
    ("Ed", 14, 81),
    ("Lisa", 14, 92),
    ("Jen", 15, 66),
]
# Since it's not just 1 item being inserted, we need to use `insertmany()`
cursor.executemany("INSERT INTO students VALUES (?,?,?)", students)

for row in cursor.execute('SELECT * FROM students'):
    print(row)

connection.close()
