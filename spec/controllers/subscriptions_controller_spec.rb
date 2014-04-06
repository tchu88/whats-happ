require 'spec_helper'

describe SubscriptionsController do  
  describe 'POST create' do
    let(:params) {{
      subscription: {
        phone: Faker::PhoneNumber.short_phone_number,
        address: Faker::Address.street_address,
        latitude: Faker::Geolocation.lat,
        longitude: Faker::Geolocation.lng,
        radius: 500
      }
    }}

    before { post :create, params }

    context 'given valid data' do
      it { should redirect_to root_path }
      it { should set_the_flash.to(I18n.t('subscriptions.create.success')) }
    end

    context 'given invalid data' do
      let(:params) {{
        subscription: {
          phone: "",
          address: Faker::Address.street_address,
          latitude: Faker::Geolocation.lat,
          longitude: Faker::Geolocation.lng,
          radius: 500
        }
      }}

      it { should render_template('subscriptions/new') }
      it { should_not set_the_flash }
    end
  end

  describe 'GET new' do
    before { get :new }

    it { should respond_with(:success) }
    it { should render_template('subscriptions/new') }
  end
end
