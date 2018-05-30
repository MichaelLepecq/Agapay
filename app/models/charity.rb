class Charity < ApplicationRecord
  include PgSearch
  has_many :categories, through: :mappings

  validates :city, presence: :true
  validates :province, presence: :true
  validates :business_number, presence: :true, uniqueness: :true


  pg_search_scope :global_search,
  against: [ :name, :city, :province ],
  associated_against: {
    category: [ :name ]
  },
  using: {
    tsearch: { prefix: true }
  }
end
