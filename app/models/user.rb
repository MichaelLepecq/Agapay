class User < ApplicationRecord
  # mount_uploader :photo, PhotoUploader

  has_many :preferences, through: :user_preference
  has_many :charities, through: :user_charity

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  # def photo_file_name
  #   self.email
  # end
end
