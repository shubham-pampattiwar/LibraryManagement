class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    devise :omniauthable, omniauth_providers: %i[facebook]
    belongs_to :university
    has_many :book_issue_history, dependent: :destroy
    has_many :bookmarks, dependent: :destroy
    validates :name, :email, :password, :education_level, :university_id, :max_books_borrowed, presence: true

    def self.from_omniauth(auth)
        where(email: auth.info.email).first_or_create do |stud|
            stud.email = auth.info.email
            stud.password = Devise.friendly_token[0, 20]
            stud.name = auth.info.name
            # user.skip_confirmation!
        end
    end
end
