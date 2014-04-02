require 'spec_helper'

describe EventRetriever do
  subject { EventRetriever.new(publisher) }
  let(:publisher) { create(:publisher, url: url) }
  let(:url) { 'https://example.com/events.json' }

  describe '#import' do
    it 'creates an event' do
      stub_request(:get, url).
        to_return(:status => 200, :body => File.read('spec/support/fixtures/events.json'))

      expect{ subject.import }.to change{ Event.count }.by(+1)
    end
  end
end
