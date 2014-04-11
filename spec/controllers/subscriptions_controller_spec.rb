require 'spec_helper'

describe SubscriptionsController do  
  describe 'POST create' do
    let(:params) {{ subscription: attributes_for(:subscription) }}

    context 'given valid data' do
      before do
        stub_sms(Subscription.normalize_phone_number(params[:subscription][:phone]), I18n.t('subscriptions.create.confirmation', title: 'CMPD'))
        post :create, params
      end

      it { should redirect_to root_path }
      it { should set_the_flash.to(I18n.t('subscriptions.create.success')) }
    end

    context 'given invalid data' do
      before { post :create, params }

      let(:params) {{ subscription: attributes_for(:subscription).merge(phone: '') }}

      it { should render_template('subscriptions/new') }
      it { should set_the_flash.to(I18n.t('subscriptions.create.failure')) }
    end
  end

  describe 'GET new' do
    before { get :new }

    it { should respond_with(:success) }
    it { should render_template('subscriptions/new') }
  end
end
