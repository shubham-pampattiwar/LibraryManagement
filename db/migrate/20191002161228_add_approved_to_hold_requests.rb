class AddApprovedToHoldRequests < ActiveRecord::Migration[5.2]
  def self.up
    add_column :hold_requests, :approved, :boolean, :default => false, :null => false
    add_index  :hold_requests, :approved
  end

  def self.down
    remove_index  :hold_requests, :approved
    remove_column :hold_requests, :approved
  end
end
