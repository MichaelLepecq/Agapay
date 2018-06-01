class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_categories
  has_many :user_charities
  has_many :categories, through: :user_categories
  has_many :charities, through: :user_charities

  #validates :first_name, presence: true
  #validates :last_name, presence: true

  # def photo_file_name
  #   self.email
  # end
end
