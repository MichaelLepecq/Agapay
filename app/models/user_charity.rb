class UserCharity < ApplicationRecord
  belongs_to :user#, dependent: :destroy
  belongs_to :charity#, dependent: :destroy
  validates :disliked, inclusion: { in: [true, false] }
end
