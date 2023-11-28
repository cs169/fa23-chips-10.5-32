# spec/controllers/session_controller_spec.rb

require 'rails_helper'

RSpec.describe SessionController, type: :controller do
  let(:user) { instance_double('User') }

  before do
    allow(controller).to receive(:require_login!)
    allow(controller).to receive(:redirect_to)
    allow(controller).to receive(:login_url)
    allow(User).to receive(:find).and_return(user)
  end

  describe 'require_login!' do
    context 'when user is logged in' do
      before do
        allow(controller).to receive(:session).and_return({ current_user_id: 1 })
      end

      it 'finds the current user' do
        expect(User).to receive(:find).with(1)
        controller.send(:require_login!)
        expect(assigns(:current_user)).to eq(nil)
      end
    end

    context 'when user is not logged in' do
      before do
        allow(controller).to receive(:session).and_return({})
        allow(controller).to receive(:request).and_return({ 'REQUEST_URI' => '/some_path' })
      end

      it 'redirects to login page and sets destination_after_login' do
        expect(controller).to receive(:redirect_to).with('login_url')
        controller.send(:require_login!)
        expect(session[:destination_after_login]).to eq(nil)
      end
    end
  end
end
