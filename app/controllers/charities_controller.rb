class CharitiesController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @charities = Charity.all
  end

  def show
    @charity = Charity.find(params[:id])
  end
end
