
# LibraryManagement

[Deployment Link](https://damp-caverns-33581.herokuapp.com/)

#### Admin

There is only one admin, the credentials for the same are as follows:
* Email: admin@ncsu.edu
* Password: zxcv0987

Admin can perform the following tasks:

* Log in with an email and password
* Edit profile
* Create/Modify Librarian or Student accounts
* Create/Modify/Delete Libraries and Books.
* View the list of users (students and librarians) and their profile details (except password)
* View the list of books, along with detailed information.
* View the list of book hold requests.
* View the list of Checked out books.
* View the list of students with books overdue (along with overdue fines).
* View the borrowing history of each book.
* Delete Student/Book/Librarian from the system

#### Librarian

Librarian can perfor mthe following tasks:

* Log in with email and password.
* Edit their own profile to choose an existing library. Each librarian can only work for one library.
* Edit library attributes.
* Add/Remove books to/from a library.
* View & Edit book information.
* View all books.
* View hold requests for any book in the library he/she works in.
* For books in the special collection, accept or deny book hold request.
* View list of all the books that are checked out from their library.
* View the borrowing history of the books from their library.
* View the list of students with overdue books from their library along with overdue fine.

### Student

Student can perform the following tasks:

* View the list of all the libraries
* Edit profile to modify email, name and password only.
* View all books
* Check out/Request/Return a book from any library associated with their University.
* Delete a reservation request, which has not been approved yet (pending).
* View/Edit their account attributes (including changing their password).
* Search through the books
* Search by title
* Search by author
* Search by publication date
* Search by subject
* Bookmark a book they are interested in.
* View their bookmarked books.
* At any given time, a student can borrow a max of 'N' number of books based on their educational level.
* View the overdue fines for his/her account.
* Receive an email when any of their book request is sucessful.

#### Note:

1) Once a new librarian signs up, he is automatically signed out of his account and not allowed to sign in till admin approves the librarian. 
2) When librarian approves hold request, book is issued automatically if it is available.
3) Rspec testing is done for:
    * Books model
    * Bookmarks model
    * Bookmarks controller


