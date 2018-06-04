class CharitiesController < ApplicationController
 before_action :authenticate_user!, only: [:favorite]

  def index
     @donation = Donation.new()
     @categories_user = current_user.categories if user_signed_in?
     @categories = Category.where('name != ? AND name != ?', 'public-benefit', 'religion')
     @charities = Charity.all
   end

   def search
    @donation = Donation.new()
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
    @donation = Donation.new
    @charity = Charity.find(params[:id])
    @markers = [{
      lat: @charity.latitude,
      lng: @charity.longitude,
    }]
  end



  def favorite
    @charity = Charity.find(charity_params[:charity_id])

    @favorite = UserCharity.where(user: current_user, charity: @charity)

    if @favorite.empty?
      @favorite = UserCharity.create(user: current_user, charity: @charity)
    else
      @favorite.first.destroy
    end
  end


  private

  def charity_params
    params.permit(:charity_id)
  end

end


# route renvoit les résultats en json
# javascript qui demandent les résultats et qui affiche

# @charities = Charity.joins(:categories).where(categories: { name: "animal", name: "environement"})
