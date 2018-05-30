class CharitiesController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    if params[:query].present?
     @charities =  Charity.global_search("%#{params[:query]}%")
    else
      @charities = Charity.all
    end
  end



  def show
    @charity = Charity.find(params[:id])
  end
end
