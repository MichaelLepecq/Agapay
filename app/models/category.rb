class Category < ApplicationRecord
  has_many :mappings
  has_many :charities, through: :mappings
end
