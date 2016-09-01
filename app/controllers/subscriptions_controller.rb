class SubscriptionsController < ApplicationController

  def destroy

    Stripe.api_key = Rails.configuration.stripe[:secret_key]
    subscription_id = Stripe::Subscription.retrieve(current_user.subscribed_id.to_s)
    subscription_id.delete

    current_user.subscribed = false
    current_user.save

    flash[:alert] = 'Your downgrade was successfully. Hope you return again.'

    redirect_to root_path

  end

end
