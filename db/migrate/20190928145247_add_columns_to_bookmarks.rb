class AddColumnsToBookmarks < ActiveRecord::Migration[5.2]
  def change
    add_reference :bookmarks, :student, index: true, foreign_key: true
    add_reference :bookmarks, :book, index: true, foreign_key: true
  end
end
