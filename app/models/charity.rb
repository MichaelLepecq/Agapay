class Charity < ApplicationRecord
  include PgSearch
  has_many :charity_categories, dependent: :destroy
  has_many :categories, through: :charity_categories
  has_many :user, through: :user_charities
  has_many :user_charities, dependent: :destroy
  has_many :pictures, dependent: :destroy
  validates :city, presence: :true
  validates :province, presence: :true
  validates :business_number, presence: :true
  validates :name, presence: true, uniqueness: true


  pg_search_scope :global_search,
  against: [ :name, :city, :province ],
  associated_against: {
    categories: [ :name ]
  },
  using: {
    tsearch: { prefix: true }
  }
  geocoded_by :city
  after_validation :geocode, if: :will_save_change_to_city?

  def liked(current_user)
    favorite = UserCharity.where(user: current_user, charity: self)
    favorite.empty? ? false : true
  end
end
