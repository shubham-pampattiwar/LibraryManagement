class Bookmark < ApplicationRecord
    belongs_to :student
    belongs_to :book
    validates :book_id, :student_id, presence: true
end
