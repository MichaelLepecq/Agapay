class Category < ApplicationRecord
  has_many :charity_categories
  has_many :charities, through: :mappings
end
