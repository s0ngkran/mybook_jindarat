from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import Optional, List
from database import get_connection, init_db
import json

app = FastAPI()

init_db()

class BookCreate(BaseModel):
    imageUrl: Optional[str] = None
    title: str
    reviewStar: int
    price: float
    isFav: Optional[bool] = False

class BookUpdate(BaseModel):
    imageUrl: Optional[str] = None
    title: Optional[str] = None
    reviewStar: Optional[int] = None
    price: Optional[float] = None
    isFav: Optional[bool] = None

class BookNoteCreate(BaseModel):
    bookId: int
    note: Optional[str] = None
    tag: Optional[List[str]] = None

class BookNoteUpdate(BaseModel):
    bookId: Optional[int] = None
    note: Optional[str] = None
    tag: Optional[List[str]] = None

@app.get("/")
def read_root():
    return {"message": "Hello, FastAPI!"}

@app.get("/books")
def get_books():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM book")
    books = [dict(row) for row in cursor.fetchall()]
    conn.close()
    return books

@app.get("/books/{book_id}")
def get_book(book_id: int):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM book WHERE id = ?", (book_id,))
    book = cursor.fetchone()
    conn.close()
    if not book:
        raise HTTPException(status_code=404, detail="Book not found")
    return dict(book)

@app.post("/books")
def create_book(book: BookCreate):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO book (imageUrl, title, reviewStar, price, isFav) VALUES (?, ?, ?, ?, ?)",
        (book.imageUrl, book.title, book.reviewStar, book.price, book.isFav)
    )
    conn.commit()
    book_id = cursor.lastrowid
    conn.close()
    return {"id": book_id, **book.model_dump()}

@app.put("/books/{book_id}")
def update_book(book_id: int, book: BookUpdate):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM book WHERE id = ?", (book_id,))
    if not cursor.fetchone():
        conn.close()
        raise HTTPException(status_code=404, detail="Book not found")

    updates = []
    values = []
    if book.imageUrl is not None:
        updates.append("imageUrl = ?")
        values.append(book.imageUrl)
    if book.title is not None:
        updates.append("title = ?")
        values.append(book.title)
    if book.reviewStar is not None:
        updates.append("reviewStar = ?")
        values.append(book.reviewStar)
    if book.price is not None:
        updates.append("price = ?")
        values.append(book.price)
    if book.isFav is not None:
        updates.append("isFav = ?")
        values.append(book.isFav)

    if updates:
        values.append(book_id)
        cursor.execute(f"UPDATE book SET {', '.join(updates)} WHERE id = ?", values)
        conn.commit()

    conn.close()
    return {"id": book_id, **book.model_dump(exclude_unset=True)}

@app.delete("/books/{book_id}")
def delete_book(book_id: int):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM book WHERE id = ?", (book_id,))
    if not cursor.fetchone():
        conn.close()
        raise HTTPException(status_code=404, detail="Book not found")

    cursor.execute("DELETE FROM book WHERE id = ?", (book_id,))
    conn.commit()
    conn.close()
    return {"message": "Book deleted successfully"}

@app.get("/book-notes")
def get_book_notes():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM bookNote")
    notes = []
    for row in cursor.fetchall():
        note_dict = dict(row)
        if note_dict['tag']:
            note_dict['tag'] = json.loads(note_dict['tag'])
        notes.append(note_dict)
    conn.close()
    return notes

@app.get("/book-notes/{note_id}")
def get_book_note(note_id: int):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM bookNote WHERE id = ?", (note_id,))
    note = cursor.fetchone()
    conn.close()
    if not note:
        raise HTTPException(status_code=404, detail="Book note not found")
    note_dict = dict(note)
    if note_dict['tag']:
        note_dict['tag'] = json.loads(note_dict['tag'])
    return note_dict

@app.get("/books/{book_id}/notes")
def get_book_notes_by_book(book_id: int):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM bookNote WHERE bookId = ?", (book_id,))
    notes = []
    for row in cursor.fetchall():
        note_dict = dict(row)
        if note_dict['tag']:
            note_dict['tag'] = json.loads(note_dict['tag'])
        notes.append(note_dict)
    conn.close()
    return notes

@app.post("/book-notes")
def create_book_note(note: BookNoteCreate):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM book WHERE id = ?", (note.bookId,))
    if not cursor.fetchone():
        conn.close()
        raise HTTPException(status_code=404, detail="Book not found")

    tag_json = json.dumps(note.tag) if note.tag else None
    cursor.execute(
        "INSERT INTO bookNote (bookId, note, tag) VALUES (?, ?, ?)",
        (note.bookId, note.note, tag_json)
    )
    conn.commit()
    note_id = cursor.lastrowid
    conn.close()
    return {"id": note_id, **note.model_dump()}

@app.put("/book-notes/{note_id}")
def update_book_note(note_id: int, note: BookNoteUpdate):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM bookNote WHERE id = ?", (note_id,))
    if not cursor.fetchone():
        conn.close()
        raise HTTPException(status_code=404, detail="Book note not found")

    if note.bookId is not None:
        cursor.execute("SELECT * FROM book WHERE id = ?", (note.bookId,))
        if not cursor.fetchone():
            conn.close()
            raise HTTPException(status_code=404, detail="Book not found")

    updates = []
    values = []
    if note.bookId is not None:
        updates.append("bookId = ?")
        values.append(note.bookId)
    if note.note is not None:
        updates.append("note = ?")
        values.append(note.note)
    if note.tag is not None:
        updates.append("tag = ?")
        values.append(json.dumps(note.tag))

    if updates:
        values.append(note_id)
        cursor.execute(f"UPDATE bookNote SET {', '.join(updates)} WHERE id = ?", values)
        conn.commit()

    conn.close()
    return {"id": note_id, **note.model_dump(exclude_unset=True)}

@app.delete("/book-notes/{note_id}")
def delete_book_note(note_id: int):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM bookNote WHERE id = ?", (note_id,))
    if not cursor.fetchone():
        conn.close()
        raise HTTPException(status_code=404, detail="Book note not found")

    cursor.execute("DELETE FROM bookNote WHERE id = ?", (note_id,))
    conn.commit()
    conn.close()
    return {"message": "Book note deleted successfully"}
