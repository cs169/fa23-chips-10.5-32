# spec/controllers/my_events_controller_spec.rb

require 'rails_helper'

RSpec.describe MyEventsController, type: :controller do
  let(:valid_attributes) do
    {
      name: 'Sample Event',
      county_id: 1,
      description: 'This is a sample event',
      start_time: Time.now,
      end_time: Time.now + 1.hour
    }
  end

  let(:invalid_attributes) do
    {
      name: '',
      county_id: 1,
      description: 'This is a sample event',
      start_time: Time.now,
      end_time: Time.now - 1.hour
    }
  end

  let(:event) { instance_double('Event', valid?: true) }

  let!(:user) do
    User.create!(provider: 1, uid: '735435765', email: 'brasberry.berkeley.edu', first_name: 'angel', last_name: 'meoww')
  end

  before do
    allow(controller).to receive(:set_event)
    allow(Event).to receive(:new).and_return(event)
    allow(event).to receive(:save).and_return(true)
    allow(event).to receive(:update).and_return(true)
    allow(Event).to receive(:find).and_return(event)
    allow(event).to receive(:destroy).and_return(true)
  end

  describe 'GET new' do
    context 'user logged in' do
      before { session[:current_user_id] = user.id }

      it 'assigns a new event as @event' do
        get :new
        expect(assigns(:event)).to be_a_new(Event)
      end
    end
    
    context 'user not logged in' do
      it 'redirects to login page' do
        get :new
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new event' do
        post :create, params: { event: valid_attributes }
        expect(response).to redirect_to(events_path)
        expect(flash[:notice]).to eq('Event was successfully created.')
      end
    end

    context 'with invalid params' do
      it 're-renders the new template' do
        allow(event).to receive(:save).and_return(false)
        post :create, params: { event: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the event' do
        patch :update, params: { id: 1, event: valid_attributes }
        expect(response).to redirect_to(events_path)
        expect(flash[:notice]).to eq('Event was successfully updated.')
      end
    end

    context 'with invalid params' do
      it 're-renders the edit template' do
        allow(event).to receive(:update).and_return(false)
        patch :update, params: { id: 1, event: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested event' do
      delete :destroy, params: { id: 1 }
      expect(response).to redirect_to(events_url)
      expect(flash[:notice]).to eq('Event was successfully destroyed.')
    end
  end
end
