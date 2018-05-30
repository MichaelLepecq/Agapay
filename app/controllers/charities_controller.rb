class CharitiesController < ApplicationController
  skip_before_action :authenticate_user!
  def index
   # binding.pry
   @categories = Category.all

    if params[:query].present?
      @charities = Charity.global_search("%#{params[:query]}%")
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
