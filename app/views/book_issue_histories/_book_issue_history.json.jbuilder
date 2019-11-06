json.extract! book_issue_history, :id, :issue_date, :return_date, :overdue_date, :created_at, :updated_at
json.url book_issue_history_url(book_issue_history, format: :json)
