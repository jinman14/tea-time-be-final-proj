class Api::V1::TeaSubscriptionsController < ApplicationController
  before_action :set_tea_subscription, only: :show

  def index
    subscriptions = TeaSubscription.all

    render json: TeaSubscriptionSerializer.format_subscription_list(subscriptions)
  end

  def show
    render json: TeaSubscriptionSerializer.format_single_subscription(@tea_sub)
  end

  private

  def set_tea_subscription
    @tea_sub = TeaSubscription.find(params[:id])
  end
end