class Charity < ApplicationRecord
  include PgSearch
  has_many :mappings
  has_many :categories, through: :charity_categories

  validates :city, presence: :true
  validates :province, presence: :true
  validates :business_number, presence: :true, uniqueness: :true


  pg_search_scope :global_search,
  against: [ :name, :city, :province ],
  associated_against: {
    categories: [ :name ]
  },
  using: {
    tsearch: { prefix: true }
  }
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
