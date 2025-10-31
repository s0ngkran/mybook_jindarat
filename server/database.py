import sqlite3
from pathlib import Path

DB_PATH = Path(__file__).parent / "database.db"

def get_connection():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn

def init_db():
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS book (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imageUrl TEXT,
            title TEXT NOT NULL,
            reviewStar INTEGER CHECK(reviewStar >= 1 AND reviewStar <= 5),
            price REAL,
            isFav BOOLEAN DEFAULT 0
        )
    """)

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS bookNote (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            bookId INTEGER NOT NULL,
            note TEXT,
            tag TEXT,
            FOREIGN KEY (bookId) REFERENCES book(id)
        )
    """)

    conn.commit()
    conn.close()
