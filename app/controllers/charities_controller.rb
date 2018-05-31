class CharitiesController < ApplicationController
  #before_action :authenticate_user!, only: [:favorite]

  def index

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

  def favorite
    # verifier si ya un favorite pour cete charite
    # si oui alors je la detruit
    # si non alors je la cree
    @charity = Charity.find(charity_params[:charity_id])

    # if favorite[:charity_id].present?
      @favorite = UserCharity.create(user: current_user, charity: @charity)
    # else
    #   @favorite.destroy
    # end
  end

  private
  def charity_params
    params.permit(:charity_id)
  end

end


# route renvoit les résultats en json
# javascript qui demandent les résultats et qui affiche

# @charities = Charity.joins(:categories).where(categories: { name: "animal", name: "environement"})
