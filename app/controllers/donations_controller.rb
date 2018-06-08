class DonationsController < ApplicationController

  def new
    @charity = Charity.find(params[:charity_id])
    @donation = Donation.new()
  end

  def index
    @donations = current_user.donations
  end

  def find_charity(charity)
    charity = Charity.find(charity)
  end

  def destroy
  end
end
