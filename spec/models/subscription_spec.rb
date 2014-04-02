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

  describe '#latitude' do
    it { should have_db_column(:latitude).of_type(:decimal).with_options(null: false, precision: 9, scale: 6) }
    it { should validate_presence_of(:latitude) }
    it { should validate_numericality_of(:latitude).is_greater_than_or_equal_to(-180) }
    it { should validate_numericality_of(:latitude).is_less_than_or_equal_to(180) }
  end

  describe '#longitude' do
    it { should have_db_column(:longitude).of_type(:decimal).with_options(null: false, precision: 9, scale: 6) }
    it { should validate_presence_of(:longitude) }
    it { should validate_numericality_of(:longitude).is_greater_than_or_equal_to(-180) }
    it { should validate_numericality_of(:longitude).is_less_than_or_equal_to(180) }
  end
end
