# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  describe 'index' do
    it 'sets all representatives when index' do
      get :index
      expect(assigns(:representatives)).to eq(Representative.all)
    end
  end

  describe 'GET index' do
    it 'returns 200 response' do
      get :index
      expect(response).to be_successful
    end

    it 'renders index' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET show' do
    it 'returns 200 response' do
      get :show
      expect(response)
    end

    it 'renders show' do
      get :show
      expect(response).to render_template('show')
    end
  end

end