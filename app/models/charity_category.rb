class CharityCategory < ApplicationRecord
  belongs_to :category
  belongs_to :charity
end
