class UserCharity < ApplicationRecord
  belongs_to :user
  belongs_to :charity
  validates :disliked, inclusion: { in: [true, false] }
end
