class BookIssueHistory < ApplicationRecord
  belongs_to :book
  belongs_to :student
  validates :issue_date , presence: true
  validates :overdue_date , presence: true
  validates :book_id , presence: true
  validates :library_id , presence: true
  validates :student_id, presence: true
end
