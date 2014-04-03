require 'spec_helper'

describe SubscriptionsController do  
  describe 'POST create' do
    let(:params) {{
      subscription: {
        phone: Faker::PhoneNumber.phone_number,
        latitude: Faker::Geolocation.lat,
        longitude: Faker::Geolocation.lng,
        radius: 500
      }
    }}

    context 'given valid data' do
      it 'creates a subscription' do
        expect { post :create, params }.to change{ Subscription.count }.by(+1)
      end

      it 'redirects to the home page' do
        post :create, params
        expect(response).to redirect_to root_path
      end
    end

    context 'given invalid data' do
      let(:invalid_params) {{
        subscription: {
          phone: "",
          latitude: Faker::Geolocation.lat,
          longitude: Faker::Geolocation.lng,
          radius: 500
        }
      }}

      it 'does not create a subscription' do
        expect { post :create, invalid_params }.not_to change{ Subscription.count }
      end
    end
  end

  describe 'GET new' do
    it 'is successful' do
      get :new
      expect(response).to be_success
    end
  end
end
