class CreateHoldRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :hold_requests do |t|

      t.timestamps
    end
  end
end
