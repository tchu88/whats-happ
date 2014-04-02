require 'spec_helper'

describe Event do
  describe '#message' do
    it { should have_db_column(:message).with_options(null: false) }
    it { should validate_presence_of(:message) }
  end

  include_examples "a longitude"
  include_examples "a latitude"
end
