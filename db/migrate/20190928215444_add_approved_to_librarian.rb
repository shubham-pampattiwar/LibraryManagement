class AddApprovedToLibrarian < ActiveRecord::Migration[5.2]
  def self.up
    add_column :librarians, :approved, :boolean, :default => false, :null => false
    add_index  :librarians, :approved
  end

  def self.down
    remove_index  :librarians, :approved
    remove_column :librarians, :approved
  end
end
