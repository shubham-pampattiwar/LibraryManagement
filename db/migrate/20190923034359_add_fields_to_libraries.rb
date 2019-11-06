class AddFieldsToLibraries < ActiveRecord::Migration[5.2]
  def change
    add_column :libraries, :location, :string
    add_column :libraries, :max_days_borrowed, :integer
    add_column :libraries, :overdue_fines, :float
  end
end
