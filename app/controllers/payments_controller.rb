class PaymentsController < ApplicationController
  before_action :set_donation, only: [:create]

  def new
  end

  def create
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,   # You should store this customer id and re-use it.
      amount:       @donation.donation_amount_cents,
      description:  "Payment for teddy #{@donation.charity} for donation #{@donation.id}",
      currency:     @donation.dontion_amount.currency
    )

    @donation.update(payment: charge.to_json, state: 'paid')
    redirect_to donation_path(@donation)

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_donation_payment_path(@donation)
    end
  end

private

  def set_donation
    @donation = current_user.donations.where(state: 'pending').find(params[:donation_id])
  end
end
