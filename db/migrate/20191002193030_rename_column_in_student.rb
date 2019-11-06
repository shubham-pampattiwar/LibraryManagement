class RenameColumnInStudent < ActiveRecord::Migration[5.2]
  def change
    rename_column :students, :max_days_borrowed, :max_books_borrowed
  end
end
