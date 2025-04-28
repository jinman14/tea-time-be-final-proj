class Api::V1::TeaSubscriptionsController < ApplicationController
  def index
    subscriptions = TeaSubscription.all

    render json: TeaSubscriptionSerializer.format_subscription_list(subscriptions)
  end
end