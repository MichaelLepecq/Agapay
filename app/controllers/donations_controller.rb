class DonationsController < ApplicationController

  def new
    @charity = Charity.find(params[:charity_id])
    @donation = Donation.new()
  end

  def index
  end

  def find_charity(charity)
    charity = Charity.find(charity)
  end

  def destroy
  end
end
