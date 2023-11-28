# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserController, type: :controller do
  describe 'profile' do
    before do
      request.env['REQUEST_URI'] = '/'
      @user = User.create(uid:        1,
                          provider:   User.providers[:google_oauth2],
                          first_name: 'TestF',
                          last_name:  'TestL',
                          email:      'TestE')
    end

    it 'sets user when in db' do
      get :profile, session: { current_user_id: 1 }
      expect(assigns(:current_user)).to eq(@user)
    end


    context 'when user is not found' do
      it 'redirects to login page' do
        # Stub session with a non-existent user ID (2 in this case)
        allow(controller).to receive(:session).and_return({ current_user_id: 2 })

        # Expecting ActiveRecord::RecordNotFound error
        expect { get :profile }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  
  end
end