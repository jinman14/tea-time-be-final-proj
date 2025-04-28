class Api::V1::TeaSubscriptionsController < ApplicationController
  before_action :set_tea_subscription, only: :show

  def index
    subscriptions = TeaSubscription.all

    render json: TeaSubscriptionSerializer.format_subscription_list(subscriptions)
  end

  def show
    render json: TeaSubscriptionSerializer.format_single_subscription(@tea_sub)
  end

  def create
    tea_subscription = TeaSubscription.create!(tea_subscription_params)
    render json: TeaSubscriptionSerializer.format_single_subscription(tea_subscription), status: :created
  end

  private

  def set_tea_subscription
    @tea_sub = TeaSubscription.find(params[:id])
  end

  def tea_subscription_params
    params.require(:tea_subscription).permit(:customer_id, :tea_id, :frequency, :status)
  end
end