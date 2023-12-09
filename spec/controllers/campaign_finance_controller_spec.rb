# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CampaignFinanceController, type: :controller do
  describe 'POST #search' do
    it 'has a 200 response' do
      allow_any_instance_of(described_class).to receive(:search).and_return(Net::HTTPSuccess.new(1.0, '200', 'OK'))
      post :search, params: { cycle: 2016, category: 'contribution-total' }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET index' do
    it 'renders index' do
      get :index
      expect(response).to render_template(:index)
    end
  end

end


