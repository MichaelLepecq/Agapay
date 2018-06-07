class CharitiesController < ApplicationController
 before_action :authenticate_user!, only: [:favorite]

  def index
    @donation = Donation.new()
    if current_user && current_user.categories.any?
      # @categories_user = current_user.categories
      # charities_user = []
      # @categories_user.each do |category|
      #   charities_user << category.charities
      # end
      # @charities = charities_user.flatten.uniq
      categories_user_ids = current_user.categories.pluck(:id)
      charity_ids = CharityCategory.where(category_id: categories_user_ids).pluck(:charity_id)
      exclude_charity_ids = UserCharity.where(user: current_user, disliked: true).pluck(:charity_id)

      charity_ids = charity_ids - exclude_charity_ids

      @charities = Charity.includes(:user_charities, :categories).where(id: charity_ids)

    elsif current_user
      charity_ids = UserCharity.where(user: current_user, disliked: true).pluck(:charity_id)
      @charities = Charity.includes(:user_charities, :categories).where.not(id: charity_ids)
    else
       @charities = Charity.includes(:user_charities, :categories).all
    end

    @categories = Category.where('name != ? AND name != ?', 'public-benefit', 'religion')

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

  def dislike
    @charity = Charity.find(charity_params[:charity_id])
    @disliked = UserCharity.where(user: current_user, charity: @charity)

    if @disliked.empty?
      @disliked = UserCharity.create(user: current_user, charity: @charity, disliked: true)
    else
      @disliked.update(disliked: true)
    end

  end

  def favorite
    @prev = Rails.application.routes.recognize_path(request.referrer)[:action]
    @charity = Charity.find(charity_params[:charity_id])

    @favorite = UserCharity.where(user: current_user, charity: @charity)

    if @favorite.empty?
      @favorite = UserCharity.create(user: current_user, charity: @charity)
    else
      @favorite.first.destroy
    end
  end

  def user_charities_index
    current_user.user_charities.pluck()
    @favorites = Charity.joins(:user_charities).where(user_charities: {user_id: current_user.id, disliked: false})

    @donation = Donation.new
  end


  private

  def charity_params
    params.permit(:charity_id)
  end
end

