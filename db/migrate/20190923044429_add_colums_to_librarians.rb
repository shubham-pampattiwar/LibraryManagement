class AddColumsToLibrarians < ActiveRecord::Migration[5.2]
  def change
    add_column :librarians, :email, :string, unique: true
    add_column :librarians, :password, :string
    add_reference :librarians, :library, index: true, foreign_key: true
  end
end
