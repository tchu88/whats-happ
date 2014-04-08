class SubscriptionsController < ApplicationController
  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      send_confirmation(@subscription)
      redirect_to root_path, notice: t('subscriptions.create.success')
    else
      flash[:error] = t('subscriptions.create.failure')
      render :new
    end
  end

  private

  def subscription_params
    params.require(:subscription).
      permit(:phone, :longitude, :latitude, :radius, :address).
      merge(format: subscription_format)
  end

  # TODO: Will need to handle multiple formats eventually
  def subscription_format
    'sms'
  end

  # TODO: replace hard coded publisher
  def send_confirmation(subscription)
    SMSNotification.new(subscription.phone, t('subscriptions.create.confirmation', title: 'CMPD')).call
  end
end
