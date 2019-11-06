class AddAdminAttributes < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :email, :string, unique: true
    add_column :admins, :password, :string
  end
end
