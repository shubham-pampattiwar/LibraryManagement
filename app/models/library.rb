class Library < ApplicationRecord
    has_many :books, dependent: :destroy
    belongs_to :university
    has_many :librarian, dependent: :destroy

    validates :name , presence: true
    validates :university_id , presence: true
    validates :location , presence: true
    validates :max_days_borrowed , presence: true , numericality: { greater_than_or_equal_to: 1 }
    validates :overdue_fines , presence: true , numericality: { greater_than_or_equal_to: 0 }
end
