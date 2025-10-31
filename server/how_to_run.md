# How to Run

## Setup

1. Install dependencies:
```bash
pip install fastapi uvicorn
```

2. Initialize database and seed data:
```bash
python seed_data.py
```

## Run Server

```bash
uvicorn main:app --reload
```

The server will start at `http://localhost:8000`

## API Documentation

Once running, visit:
- Swagger UI: `http://localhost:8000/docs`
- ReDoc: `http://localhost:8000/redoc`

## API Endpoints

### Books
- `GET /books` - Get all books
- `GET /books/{id}` - Get book by ID
- `POST /books` - Create new book
- `PUT /books/{id}` - Update book
- `DELETE /books/{id}` - Delete book

### Book Notes
- `GET /book-notes` - Get all book notes
- `GET /book-notes/{id}` - Get book note by ID
- `GET /books/{bookId}/notes` - Get all notes for a book
- `POST /book-notes` - Create new book note
- `PUT /book-notes/{id}` - Update book note
- `DELETE /book-notes/{id}` - Delete book note
