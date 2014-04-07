require 'spec_helper'

describe EventsController do
  context 'GET index' do
    it 'responds with matching events' do
      events = create_list(:event, 3, latitude: 35.000, longitude: -87.000)
      create(:event, latitude: 40.000, longitude: -90.000)
      get :index, format: :json, latitude: 35.000, longitude: -87.000, radius: 100

      expect(response.body).to eq events.to_json
    end
  end
end
