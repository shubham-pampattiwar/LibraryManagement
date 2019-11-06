class AddQueueNumberToHoldRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :hold_requests, :queuenumber, :integer
  end
end
