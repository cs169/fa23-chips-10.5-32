require 'rails_helper'
require 'spec_helper'

RSpec.describe Event, type: :model do

  describe '#county_names_by_id' do
    let(:event) { described_class.new } 

    context 'when county and state exist' do
      it 'returns a hash of county names by ID' do
        # Assuming you have appropriate setup for the counties and state
        allow(event).to receive(:county_names_by_id).and_return({ 'County Name' => 'OC' })
        expect(event.county_names_by_id).to eq({ 'County Name' => 'OC' })
      end
    end

    context 'when county or state is nil' do
      it 'returns an empty hash' do
        allow(event).to receive_message_chain(:county, :state, :counties).and_return(nil)
        expect(event.county_names_by_id).to eq({})
      end
    end
  end
end
