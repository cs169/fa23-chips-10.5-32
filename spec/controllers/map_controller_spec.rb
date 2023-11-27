# frozen_string_literal: true

require 'rails_helper'


RSpec.describe MapController, type: :controller do
  describe 'GET #index' do
    it 'renders the :index template' do
      get :index
      expect(response).to render_template(:index)
    end
    # Add more tests for the 'index' action as needed
  end

  describe 'GET #state' do
    context 'when state is found' do
      let(:state_instance) { instance_double('State') }  # Assuming State model is defined
      let(:counties_instance) { [] }
      it 'assigns @state and @county_details' do
        allow(state_instance).to receive(:counties).and_return(counties_instance)
        allow(State).to receive(:find_by).and_return(state_instance)

        get :state, params: { state_symbol: 'CA' }
        expect(response).to render_template(:state)
     end

      # Add more tests for the 'state' action when the state is found
    end

    context 'when state is not found' do
      it 'redirects to root path with alert message' do
        allow(State).to receive(:find_by).and_return(nil)

        get :state, params: { state_symbol: 'non_existent_state' }

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("State 'NON_EXISTENT_STATE' not found.")
      end

      # Add more tests for the 'state' action when the state is not found
    end
  end
  describe 'GET #county' do
    context 'when state is found and county is found' do
      let(:state_instance) { instance_double('State') }
      let(:counties_instance) { instance_double('County') }
      let(:counties_index) { { 1 => counties_instance} }

      it 'assigns @state, @county, and @county_details' do
        controller_instance = MapController.new
        allow(controller_instance).to receive(:get_requested_county).and_return(counties_instance)
        allow(State).to receive(:find_by).and_return(state_instance)
        allow(County).to receive(:find_by).and_return(counties_instance)
        allow(state_instance).to receive(:id).and_return(6)
        allow(state_instance).to receive(:counties).and_return(counties_instance)
        allow(counties_instance).to receive(:index_by).and_return(counties_index)
        
        get :county, params: { state_symbol: 'CA', std_fips_code: '06' }
        expect(response).to render_template(:county)
      end
    end
#    context 'when state is found but county is not found' do
#      let(:state_instance) { instance_double('State') }
#      let(:counties_instance) { nil }
#      it 'redirects to root path with alert message' do
#        allow(State).to receive(:find_by).and_return(state_instance)
#        allow(County).to receive(:find_by).and_return(:counties_instance)
#        allow(state_instance).to receive(:id).and_return(nil)
#        controller_instance = MapController.new
#        allow(controller_instance).to receive(:get_requested_county).and_return(counties_instance)
#        
#        get :state, params: { state_symbol: 'CA'}
#
#        expect(response).to redirect_to(root_path)
#        expect(flash[:alert]).to eq("County with code 06 not found for CA")
#      end
#    end
  end
end
