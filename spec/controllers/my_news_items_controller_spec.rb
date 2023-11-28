# spec/controllers/my_news_items_controller_spec.rb

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  let(:valid_attributes) do
    {
      news: 'Sample news content',
      title: 'Sample News',
      description: 'This is a sample news item',
      link: 'https://samplelink.com',
      representative_id: 1
    }
  end

  let(:invalid_attributes) do
    {
      news: '',
      title: '',
      description: '',
      link: '',
      representative_id: nil
    }
  end

  let(:news_item) { instance_double('NewsItem', valid?: true) }
  let(:representative) { instance_double('Representative') }

  before do
    allow(controller).to receive(:set_representative)
    allow(controller).to receive(:set_representatives_list)
    allow(controller).to receive(:set_news_item)
    allow(Representative).to receive(:find).and_return(representative)
    allow(NewsItem).to receive(:new).and_return(news_item)
    allow(news_item).to receive(:save).and_return(true)
    allow(news_item).to receive(:update).and_return(true)
    allow(NewsItem).to receive(:find).and_return(news_item)
    allow(news_item).to receive(:destroy).and_return(true)
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new news item' do
        post :create, params: { news_item: valid_attributes, representative_id: 1 }
        expect(response).to redirect_to(representative_news_item_path(representative, news_item))
        expect(flash[:notice]).to eq('News item was successfully created.')
      end
    end

    context 'with invalid params' do
      it 're-renders the new template' do
        allow(news_item).to receive(:save).and_return(false)
        post :create, params: { news_item: invalid_attributes, representative_id: 1 }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the news item' do
        patch :update, params: { id: 1, news_item: valid_attributes, representative_id: 1 }
        expect(response).to redirect_to(representative_news_item_path(representative, news_item))
        expect(flash[:notice]).to eq('News item was successfully updated.')
      end
    end

    context 'with invalid params' do
      it 're-renders the edit template' do
        allow(news_item).to receive(:update).and_return(false)
        patch :update, params: { id: 1, news_item: invalid_attributes, representative_id: 1 }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested news item' do
      delete :destroy, params: { id: 1, representative_id: 1 }
      expect(response).to redirect_to(representative_news_items_path(representative))
      expect(flash[:notice]).to eq('News was successfully destroyed.')
    end
  end
end
