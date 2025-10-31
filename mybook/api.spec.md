## Books API

### Get all books
```bash
curl http://localhost:8000/books
```

### Create new book
```bash
curl -X POST http://localhost:8000/books \
  -H "Content-Type: application/json" \
  -d '{
    "title": "haha 2",
    "reviewStar": 2,
    "price": 399.00,
    "imageUrl": "https://example.com/image.jpg",
    "isFav": false
  }'
```

### Update book
only isFav is allowed
```bash
curl -X PUT http://localhost:8000/books/1 \
  -H "Content-Type: application/json" \
  -d '{
    "title": "haha edited",
    "price": 450.00,
    "isFav": true
  }'
```

## Book Notes API

### Get all book notes
```bash
curl http://localhost:8000/book-notes
```


### Create new book note
```bash
curl -X POST http://localhost:8000/book-notes \
  -H "Content-Type: application/json" \
  -d '{
    "bookId": 1,
    "note": "ooo",
    "tag": ["romance", "action", "favorite"]
  }'
```

### Update book note
```bash
curl -X PUT http://localhost:8000/book-notes/1 \
  -H "Content-Type: application/json" \
  -d '{
    "note": "updated note",
    "tag": ["romance", "drama"]
  }'
```

### Delete book note
```bash
curl -X DELETE http://localhost:8000/book-notes/1
```
