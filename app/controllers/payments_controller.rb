class PaymentsController < ApplicationController
  # before_action :set_donation, only: [:create]
 before_action :authenticate_user!, only: [:create]

  def new
  end

  def create

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

    if charge.failure_code == nil && charge.status == "succeeded"
      donation = Donation.create!({
        donation_amount: donation_amount.to_i,
        user: current_user,
        state: 'accepted', # FIXME Remove
        charity: charity,

      })
      flash[:notice] = "Thank you for your payment"
      # redirect_to donations_path
    else
      flash[:alert] = "Payment didn't go through"# flash a messages
    end

    redirect_to charities_path
  end

private

  def set_donation
    @donation = current_user.donations.where(state: 'pending').find(params[:donation_id])
  end
end
