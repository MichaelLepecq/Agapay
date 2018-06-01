class CategoriesController < ApplicationController
  def index
    @categories = Category.where.not(name: ["public-benefit", "religion"])
  end
end
