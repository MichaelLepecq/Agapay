class CharitiesController < ApplicationController
  skip_before_action :authenticate_user!
  def index
   @categories = Category.all
   @charities = Charity.all
  end

  def search
    if params[:query].present?
      charities_1 = Charity.global_search("%#{params[:query]}%")
      arr = []
      Category.all.each do |cat|
        arr << cat.name if params[cat.name]
      end
      charities_2 = Charity.select{ |charity| (charity.categories.pluck(:name)&arr).any? }
      @charities = charities_1&charities_2
      # binding.pry
      if @charities.count == 0
        @charities = Charity.all
      end
    else
      @charities = Charity.all
    end
  end

  def show
    @charity = Charity.find(params[:id])
    @markers = [{
      lat: @charity.latitude,
      lng: @charity.longitude,
    }]
  end
  end


# route renvoit les résultats en json
# javascript qui demandent les résultats et qui affiche

# @charities = Charity.joins(:categories).where(categories: { name: "animal", name: "environement"})
