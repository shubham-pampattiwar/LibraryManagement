class AddFieldsToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :isbn, :string
    add_column :books, :author, :string
    add_column :books, :language, :string
    add_column :books, :published, :date
    add_column :books, :edition, :integer
    add_column :books, :cover_image, :string
    add_column :books, :subject, :string
    add_column :books, :summary, :text
    add_column :books, :special_collection, :boolean
    add_column :books, :quantity, :integer
  end
end
