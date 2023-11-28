# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AjaxController, type: :controller do
  describe 'GET #counties' do
    let(:state) { instance_double('State') } # Assuming you have a State factory
    let(:county_double) {instance_double('County')}
    it 'returns JSON with counties for a state' do
      allow(State).to receive(:find_by).and_return(state)
      allow(state).to receive(:counties).and_return([county_double, county_double])
      get :counties, params: { state_symbol: 'CA' }, format: :json

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json')

      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to be_an(Array)
      # Add more specific expectations based on the structure of your JSON response
    end

    it 'returns not found if state is not found' do
      allow(State).to receive(:find_by).and_return(nil)
      #allow(state).to receive(:counties).and_return([])
      get :counties, params: { state_symbol: 'XX' }, format: :json
      expect(response).to have_http_status(:not_found)
      expect(response.content_type).to eq('application/json')
      expect(JSON.parse(response.body)).to eq({ 'error' => 'State not found' })
    end
  end
end
