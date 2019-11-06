class AddForeignKeysToBookIssueHistory < ActiveRecord::Migration[5.2]
  def change
    add_reference :book_issue_histories, :student, index: true, foreign_key: true
    add_reference :book_issue_histories, :library, index: true, foreign_key: true
    add_reference :book_issue_histories, :book, index: true, foreign_key: true
  end
end
