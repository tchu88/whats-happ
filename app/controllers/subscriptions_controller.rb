class SubscriptionsController < ApplicationController
  def new
  end

  def create
    subscription = Subscription.new(subscription_params)
    subscription.save
    redirect_to root_path
  end

  private

  def subscription_params
    params.require(:subscription).permit(:phone, :longitude, :latitude, :radius)
  end
end
