class AddColumnsToStudent < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :email, :string
    add_column :students, :password, :string
    add_column :students, :education_level, :string
    add_column :students, :max_days_borrowed, :integer
  end
end
