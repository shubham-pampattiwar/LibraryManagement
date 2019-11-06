class CreateBookIssueHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :book_issue_histories do |t|
      t.date :issue_date
      t.date :return_date
      t.date :overdue_date

      t.timestamps
    end
  end
end
