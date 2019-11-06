Rails.application.routes.draw do
  devise_for :students, controllers: { sessions: 'students/sessions', registrations: 'students/registrations', omniauth_callbacks: 'students/omniauth_callbacks'}
  devise_for :admins, controllers: { sessions: 'admins/sessions', registrations: 'admins/registrations'}
  devise_for :librarians, controllers: { sessions: 'librarians/sessions', registrations: 'librarians/registrations'}

  get 'welcome/index'
  resources :books
  resources :librarians
  resources :students
  resources :admins
  resources :libraries
  resources :universities
  resources :bookmarks
  resources :book_issue_histories
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'getallUsers' => 'admins#getallusers', :as => :getallusers
  get 'checkout' => 'books#checkout', :as => :checkout
  get 'return' => 'books#return', :as => :return
  get 'getlibrarybooks' => 'books#getlibrarybooks', :as => :getlibrarybooks
  get 'getstudentlibraries' => 'students#getstudentlibraries', :as => :getstudentlibraries
  get 'getstudentbooks' => 'books#getstudentbooks', :as => :getstudentbooks
  get 'librarianssignup' => 'librarians#signup', :as => :librarianssignup
  get 'signup_approvals' => 'admins#getsignupapprovals', :as => :get_signupapprovals
  get 'approve_librarian/:id' => 'admins#approve_librarian', :as => :approve_librarian
  get 'login' => 'librarians#login', :as => :login
  get 'studentlogin' => 'students#login' , :as => :studentlogin
  get 'addbookmark/:id' => 'bookmarks#addbookmark', :as => :addbookmark
  get 'unbookmark/:id' => 'bookmarks#unbookmark', :as => :unbookmark
  get 'showbookmarks' => 'bookmarks#showbookmarks', :as => :showbookmarks
  get 'showrequests' => 'books#showrequests', :as => :showrequests
  get 'deleterequest/:request_id' => 'books#deleterequest', :as => :deleterequest
  get 'searchbooks' => 'books#search', :as => :search
  get 'showrequestsforlib' => 'books#showrequestsforlib', :as => :showrequestsforlib
  get 'checkedoutbookslib' => 'books#checkedoutbookslib', :as => :checkedoutbookslib
  get 'bookhistlib' => 'books#bookhistlib', :as => :bookhistlib
  get 'displaysearch' => 'books#displaysearch', :as => :displaysearch
  get 'showstudentprofile' => 'students#showstudentprofile', :as => :showstudentprofile
  get 'specialcollectionbooks' => 'librarians#specialcollectionbooks', :as => :specialcollectionbooks
  get 'approve_sprequest/:id' => 'librarians#approve_sprequest', :as => :approve_sprequest
  get 'studentoverduefine' => 'book_issue_histories#studentoverduefine', :as => :studentoverduefine
  get 'studentlibraryfine' => 'book_issue_histories#studentlibraryfine', :as => :studentlibraryfine
  get 'studentcheckedout' => 'book_issue_histories#studentcheckedout', :as => :studentcheckedout
  get 'showrequestsforadmin' => 'books#showrequestsforadmin', :as => :showrequestsforadmin
  get 'borrowhistory/:id' => 'books#borrowhistory', :as => :borrowhistory
end
