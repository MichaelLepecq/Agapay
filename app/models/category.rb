class Category < ApplicationRecord
  has_many :charity_categories
  has_many :charities, through: :charity_categories

  CATEGORY_PRETTY_NAME_LOOKUP = {
    "environment" => "Environment",
    "international" => "International",
    "health" => "Health",
    "arts-culture" => "Art & Culture",
    "animals" => "Animals",
    "education" => "Education",
    "social-services" => "Social Services",
    "indigenous-people" => "Indigenous Peoples"
  }

  def pretty_name
    CATEGORY_PRETTY_NAME_LOOKUP[self.name]
  end
end
