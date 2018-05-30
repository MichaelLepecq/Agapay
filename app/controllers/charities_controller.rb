class CharitiesController < ApplicationController
  skip_before_action :authenticate_user!
  def index

   @categories = Category.all

    if params[:query].present?
      @charities = Charity.global_search("%#{params[:query]}%")
      binding.pry
      if @charities.count == 0
        @charities = Charity.all
      end
    else
      @charities = Charity.all
    end
  end


  def show
    @charity = Charity.find(params[:id])
  end
end


# route renvoit les résultats en json
# javascript qui demandent les résultats et qui affiche

# @charities = Charity.joins(:categories).where(categories: { name: "animal", name: "environement"})
