class AddFkToBooks < ActiveRecord::Migration[5.2]
  def change
    add_reference :books, :library, index: true, foreign_key: true
    add_reference :libraries, :university, index: true, foreign_key: true
  end
end
