require 'spec_helper'

describe StreamUpdate do
  subject { StreamUpdate.new(publisher) }
  let(:publisher) { create(:publisher, url: url) }
  let(:url) { 'https://example.com/events.json' }

  describe '#call' do
    context "success" do
      before do
        stub_request(:get, url).
          to_return(status: 200, body: File.read('spec/support/fixtures/events.json'))
      end

      it 'creates an event' do
        expect { subject.call }.to change{ Event.count }.by(+1)
      end

      it 'returns the created events' do
        new_events = subject.call
        expect(new_events.length).to eq 1
        expect(new_events.first.message).to eq "hello human"
        expect(new_events.first.publisher).to eq publisher
      end
    end

    context "failure" do
      context "invalid" do
        before do
          stub_request(:get, url).
            to_return(status: 200, body: File.read('spec/support/fixtures/invalid-events.json'))
        end

        it 'returns the list of events' do
          new_events = subject.call
          expect(new_events.length).to eq 0
        end
      end

      context "duplicate" do
        before do
          stub_request(:get, url).
            to_return(status: 200, body: File.read('spec/support/fixtures/duplicate-events.json'))
        end

        it 'does not create duplicate records' do
          create(:event, message: 'hello human')
          expect { subject.call }.not_to change{ Event.count }
        end
      end
    end

  end
end
