class UserCharity < ApplicationRecord
  belongs_to :user
  belongs_to :charity
  validates :bookmarked, inclusion: { in: [true, false] }
  validates :disliked, inclusion: { in: [true, false] }
end
