class AddColumnstoHoldRequests < ActiveRecord::Migration[5.2]
  def change
    add_reference :hold_requests, :student, index: true, foreign_key: true
    add_reference :hold_requests, :book, index: true, foreign_key: true
  end
end
