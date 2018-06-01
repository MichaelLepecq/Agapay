class Donation < ApplicationRecord
  belongs_to :charity
  belongs_to :user
  validates :state, presence: :true, inclusion: { in: ["pending", "accepted"]}
  # monetize  :donation_amount_cents
end
