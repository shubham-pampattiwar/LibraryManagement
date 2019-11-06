class University < ApplicationRecord
  has_many :libraries, dependent: :destroy
  has_many :students, dependent: :destroy
  validates :name , presence: true
end
