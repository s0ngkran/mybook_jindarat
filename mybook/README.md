## req
- all texts should be in Thai Lang
- separate files
- create model file
- use GetX Service as global state
  - books Book[]
  - notes BookNote[]
- create service file to interact with server (fastapi); you can check at api.spec.md; that are all apis you can use

## lib
- GetX cli when create new page/screen or controller
- Dio for request
- bottom nav with 3 buttons (home, heart, editIcon)

## screens
- book list (home)
  - search book based on all fields
  - when tap a book, nav to book detail page; book detail show all details of that book; has fav button to fav
- myBook (heart)
  - show all book fav; when tap each faved book, show detail
- bookNote (editIcon)
  - form
    - textfield note
    - textfield tag
  - listview of note in that book
    - edit button
      - show dialog to edit that note of that book
    - delete button
      - show confirm dialog before user delete

