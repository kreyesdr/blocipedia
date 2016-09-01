class ChargesController < ApplicationController

  before_filter :authenticate_user!

  class Amount
    def self.default
      5_00
    end
  end

  def create
    customer = Stripe::Customer.create(
        email: current_user.email,
        card: params[:stripeToken],
        plan: 1020
    )

    charge = Stripe::Charge.create(
        customer: customer.id,
        amount: Amount.default,
        description: "BigMoney Membership - #{current_user.email}",
        currency: 'usd'
    )

    current_user.customer_id = customer.id
    current_user.subscribed_id = customer.subscriptions.data[0].id
    current_user.subscribed = true
    current_user.save

    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to create private wikis!"
    redirect_to root_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "BigMoney Membership - #{current_user.email}",
        amount: Amount.default
    }
  end
end
