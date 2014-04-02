require 'spec_helper'

describe Publisher do
  describe '#title' do
    it { should have_db_column(:title).with_options(null: false) }
    it { should validate_presence_of(:title) }

    it { should have_db_index(:title).unique(true) }
    it {
      create(:publisher)
      should validate_uniqueness_of(:title)
    }
  end

  describe '#url' do
    it { should have_db_column(:url).with_options(null: false) }
    it { should validate_presence_of(:url) }

    it { should have_db_index(:url).unique(true) }
    it {
      create(:publisher)
      should validate_uniqueness_of(:url)
    }

    it { should allow_value('https://example.com/events.json').for(:url) }
    it { should_not allow_value('example/events.json').for(:url) }
  end
end
