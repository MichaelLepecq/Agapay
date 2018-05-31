class CharitiesController < ApplicationController
  skip_before_action :authenticate_user!
  def index
     @categories = Category.all
     @charities = Charity.all
   end

   def search
    if params[:query].present?
      @charities = Charity.global_search("%#{params[:query]}%")
    else
      @charities = Charity.all
    end


    if params[:categories].present?
      category_ids = params[:categories].keys
      charity_ids = @charities.pluck(:id)

      @charities = Charity.joins(:charity_categories).where(
        charity_categories: {
          category_id: category_ids
        },
        id: charity_ids
      ).uniq
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
