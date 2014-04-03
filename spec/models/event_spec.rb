require 'spec_helper'

describe Event do
  it { should belong_to(:publisher) }

  describe '#publisher_id' do
    it { should have_db_column(:publisher_id) }
    it { should have_db_index(:publisher_id) }
  end

  describe '#message' do
    it { should have_db_column(:message).with_options(null: false) }
    it { should validate_presence_of(:message) }
  end

  include_examples "a longitude"
  include_examples "a latitude"
end
