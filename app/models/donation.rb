class Donation < ApplicationRecord
  belongs_to :charity
  belongs_to :user
  validates :state, presence: :true, inclusion: { in: ["pending", "accepted"]}
  validates :donation_amount, presence: :true, numericality: { only_integer: true }
end
