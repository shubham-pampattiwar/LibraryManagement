class Librarian < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :library
  validates :name, :email, :library_id, presence: true
  validates :password, presence: true, :if =>:password

 # enum role: [:student, :lib, :admin]
 # after_initialize :set_default_role, :if => :new_record?

 # def set_default_role
 #  self.role ||= :student
 # end
  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : :not_approved
  end

end
