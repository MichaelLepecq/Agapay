class Charity < ApplicationRecord
  has_many :categories, through: :mapping
  validates :city, presence: :true
  validates :province, presence: :true
  validates :business_number, presence: :true, uniqueness: :true
end
