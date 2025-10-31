use sqlite

## table
### book
id int
imageUrl
title
reviewStar (1 to 5)
price

### bookNote
id int
bookId int
note string
tag string[]

## api
CRUD
