require 'spec_helper'

describe Subscription do
  describe '.contains' do
    let!(:old_city_hall) { create(:subscription, latitude: 35.2221428, longitude: -80.8390033, radius: 500) }
    let!(:plaza_home) { create(:subscription, latitude: 35.223177, longitude: -80.810581, radius: 500) }

    it 'finds subscription with areas containing the given coordinates' do
      subsciptions = Subscription.contains(latitude: 35.221277, longitude: -80.839268)
      expect(subsciptions).to eq [old_city_hall]
    end
  end

  describe '#phone' do
    it { should have_db_column(:phone).of_type(:string).with_options(null: false) }
    it { should have_db_index(:phone) }
  end

  describe '#radius' do
    it { should have_db_column(:radius).of_type(:integer).with_options(null: false) }
    it { should validate_presence_of(:radius) }
    it { should validate_numericality_of(:radius).is_greater_than(0) }
  end

  describe '#address' do
    it { should respond_to(:address) }
    it { should respond_to(:address=) }
  end

  describe '#format' do
    it { should have_db_column(:format).of_type(:string).with_options(null: false, default: '') }
    it { should validate_presence_of(:format) }
    it { should ensure_inclusion_of(:format).in_array(Subscription::FORMATS) }
  end

  include_examples "a longitude"
  include_examples "a latitude"
end
