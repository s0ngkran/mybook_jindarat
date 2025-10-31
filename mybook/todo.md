# MyBook Flutter App - TODO

## Color Style
- purple pastel
- curved

## Setup & Configuration
- [ ] Setup Flutter project with GetX CLI
- [ ] Add dependencies (GetX, Dio)
- [ ] Configure API base URL (http://localhost:8000)

## Models
- [ ] Create Book model
  - id
  - title
  - reviewStar
  - price
  - imageUrl
  - isFav
- [ ] Create BookNote model
  - id
  - bookId
  - note
  - tag (List<String>)

## Services
- [ ] Create GetX Service for global state management
  - books (List<Book>)
  - notes (List<BookNote>)
- [ ] Create API service using Dio
  - GET /books
  - POST /books
  - PUT /books/:id (update isFav only)
  - GET /book-notes
  - POST /book-notes
  - PUT /book-notes/:id
  - DELETE /book-notes/:id

## Shared Widgets (lib/shared/)
- [ ] Create reusable BookCard widget
  - Used in: Book List Screen, My Books Screen
  - Display: title, reviewStar, price, imageUrl, isFav
  - onTap navigation to detail page
- [ ] Create reusable BookDetailView widget
  - Used in: Book List Screen detail, My Books Screen detail
  - Show all book details with favorite toggle button
- [ ] Create reusable ConfirmDialog widget
  - Used in: Book Notes delete confirmation
- [ ] Create reusable NoteEditDialog widget
  - Used in: Book Notes edit functionality
  - TextField for note and tags

## UI/Navigation
- [ ] Setup bottom navigation bar with 3 tabs
  - Home (book list icon)
  - Heart (favorites)
  - Edit icon (book notes)

## Screens

### Book List Screen (Home)
- [ ] Create book list page with GetX CLI
- [ ] Display all books in list/grid
- [ ] Implement search functionality (search all book fields)
- [ ] On book tap, navigate to book detail page
- [ ] Book detail page
  - Show all book details (title, reviewStar, price, imageUrl)
  - Add favorite button to toggle isFav

### My Books Screen (Heart)
- [ ] Create favorites page with GetX CLI
- [ ] Display only favorited books (isFav = true)
- [ ] On book tap, show book details
- [ ] Sync with book list favorites

### Book Notes Screen (Edit Icon)
- [ ] Create book notes page with GetX CLI
- [ ] Create note form
  - TextField for note
  - TextField for tags
  - Submit button to create note
- [ ] Display list of notes
- [ ] For each note item:
  - Show note content and tags
  - Edit button � show dialog to edit note
  - Delete button � show confirmation dialog before delete

## Localization
- [ ] Ensure all UI texts are in Thai language
  - Button labels
  - Placeholder texts
  - Dialogs
  - Error messages

## Testing
- no testing
