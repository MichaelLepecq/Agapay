class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_many :user_categories
  has_many :user_charities
  has_many :categories, through: :user_categories
  has_many :charities, through: :user_charities
  has_many :donations

  mount_uploader :photo, PhotoUploader



  #validates :first_name, presence: true
  #validates :last_name, presence: true



  def has_category_as_preference(category)
    self.categories.include?(category)
  end

  def photo_file_name
    self.photo.filename
  end


end
