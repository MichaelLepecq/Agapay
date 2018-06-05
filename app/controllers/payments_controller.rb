class PaymentsController < ApplicationController
  # before_action :set_donation, only: [:create]
 before_action :authenticate_user!, only: [:create]

  def new
  end

  def create
    redirect_to charities_path
    charity = Charity.find(params[:charity_id])
    donation_amount = params[:donation][:donation_amount]

    customer = Stripe::Customer.create(
      source: params[:stripe_token],
      email:  current_user.email
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,   # You should store this customer id and re-use it.
      amount:       donation_amount.to_i * 100,
      description:  "Donation of #{donation_amount} to #{charity.name}",
      currency:     "CAD"
    )
  end

private

  def set_donation
    @donation = current_user.donations.where(state: 'pending').find(params[:donation_id])
  end
end
