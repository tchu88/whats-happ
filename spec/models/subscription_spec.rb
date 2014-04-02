require 'spec_helper'

describe Subscription do
  describe '#phone' do
    it { should have_db_column(:phone).of_type(:string).with_options(null: false) }
    it { should have_db_index(:phone) }
  end

  describe '#radius' do
    it { should have_db_column(:radius).of_type(:integer).with_options(null: false) }
    it { should validate_presence_of(:radius) }
    it { should validate_numericality_of(:radius).is_greater_than(0) }
  end

  include_examples "a longitude"
  include_examples "a latitude"
end
