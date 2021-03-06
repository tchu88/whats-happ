shared_examples_for "a longitude" do
  describe '#longitude' do
    it { should have_db_column(:longitude).of_type(:decimal).with_options(null: false, precision: 9, scale: 6) }
    it { should validate_presence_of(:longitude) }
    it { should validate_numericality_of(:longitude).is_greater_than_or_equal_to(-180) }
    it { should validate_numericality_of(:longitude).is_less_than_or_equal_to(180) }
  end
end

shared_examples_for "a latitude" do
  describe '#latitude' do
    it { should have_db_column(:latitude).of_type(:decimal).with_options(null: false, precision: 9, scale: 6) }
    it { should validate_presence_of(:latitude) }
    it { should validate_numericality_of(:latitude).is_greater_than_or_equal_to(-180) }
    it { should validate_numericality_of(:latitude).is_less_than_or_equal_to(180) }
  end
end
