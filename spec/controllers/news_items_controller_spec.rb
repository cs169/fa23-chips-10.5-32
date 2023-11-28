require 'rails_helper'
RSpec.describe NewsItemsController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new news item' do
        expect {
          post :create, params: { news_item: { title: 'Test Title', description: 'Test Description', link: 'http://example.com', representative_id: representative.id } }
        }.to change(NewsItem, :count).by(1)
        
        expect(response).to redirect_to(representative_news_item_path(assigns(:representative), assigns(:news_item)))
        expect(flash[:notice]).to eq('News item was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new news item' do
        expect {
          post :create, params: { news_item: { title: '', description: 'Test Description', link: 'http://example.com', representative_id: representative.id } }
        }.to_not change(NewsItem, :count)
        
        expect(response).to render_template(:new)
        expect(flash[:error]).to eq('An error occurred when creating the news item.')
      end
    end
  end
end
