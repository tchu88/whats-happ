require 'spec_helper'

describe Event do
  it { should belong_to(:publisher) }

  describe '.within' do
    it 'finds event with the area defined by a given latitude and longitude' do
      events = create_list(:event, 3, latitude: 35.000, longitude: -87.000)
      create(:event, latitude: 40.000, longitude: -90.000)

      result = Event.within(latitude: 35.000, longitude: -87.000, radius: 100)
      expect(result).to eq events
    end
  end

  describe '.last_week' do
    it 'find events within the last week' do
      too_old = create(:event, created_at: 2.weeks.ago)
      recent = create(:event)
      expect(Event.last_week).to eq [recent]
    end
  end

  describe '#publisher_id' do
    it { should have_db_column(:publisher_id) }
    it { should have_db_index(:publisher_id) }
  end

  describe '#message' do
    it { should have_db_column(:message).with_options(null: false) }
    it { should validate_presence_of(:message) }

    it { should have_db_index(:message).unique(true) }
    it {
      create(:event)
      should validate_uniqueness_of(:message)
    }
  end

  include_examples "a longitude"
  include_examples "a latitude"
end
