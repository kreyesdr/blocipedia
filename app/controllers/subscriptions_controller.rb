class SubscriptionsController < ApplicationController

  def cancel

    Stripe.api_key = Rails.configuration.stripe[:secret_key]
    subscription_id = Stripe::Subscription.retrieve(current_user.subscribed_id)
    subscription_id.delete

    redirect_to root_path

  end

end
