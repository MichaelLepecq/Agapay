class DonationsController < ApplicationController
  def create
    charity = Charity.find(params[:charity_id])
    donation = Donation.create!({donation_amount: params[:amount], user: current_user, state: 'pending'})
  end

  def destroy
  end
end
