class SubscriptionsController < ApplicationController
  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      redirect_to root_path, notice: t('subscriptions.create.success')
    else
      render :new
    end
  end

  private

  def subscription_params
    params.require(:subscription).
      permit(:phone, :longitude, :latitude, :radius).
      merge(format: subscription_format)
  end

  # TODO: Will need to handle multiple formats eventually
  def subscription_format
    'sms'
  end
end
