# TODO

## Database Setup
- [ ] Set up SQLite database
- [ ] Create `book` table with fields:
  - id (int)
  - imageUrl
  - title
  - reviewStar (1 to 5)
  - price
- [ ] Create `bookNote` table with fields:
  - id (int)
  - bookId (int, foreign key)
  - note (string)
  - tag (string array)

## API Implementation
- [ ] Implement CRUD for `book`
  - [ ] Create book
  - [ ] Read book(s)
  - [ ] Update book
  - [ ] Delete book
- [ ] Implement CRUD for `bookNote`
  - [ ] Create book note
  - [ ] Read book note(s)
  - [ ] Update book note
  - [ ] Delete book note
