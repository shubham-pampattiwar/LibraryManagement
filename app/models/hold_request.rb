class HoldRequest < ApplicationRecord
  belongs_to :book
  validates :book_id, :student_id, :queuenumber, presence: true
end
