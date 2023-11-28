# spec/controllers/application_controller_spec.rb

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: 'Test'
    end
  end

  describe 'authenticated' do
    context 'when session[:current_user_id] is present' do
      it 'sets @authenticated to true' do
        session[:current_user_id] = 123 # Example user ID

        get :index

        expect(assigns(:authenticated)).to be_truthy
      end
    end

    context 'when session[:current_user_id] is nil' do
      it 'sets @authenticated to false' do
        session[:current_user_id] = nil

        get :index

        expect(assigns(:authenticated)).to be_falsey
      end
    end
  end
end
