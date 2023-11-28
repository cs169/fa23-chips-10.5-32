require 'rails_helper'

RSpec.describe NewsItem, type: :model do
  describe 'associations' do
    it { should belong_to(:representative) }
    it { should have_many(:ratings).dependent(:delete_all) }
  end

  describe 'class methods' do
    describe '.find_for' do
      let(:representative_id) { 1 }

      context 'when news item exists for given representative_id' do
        let!(:news_item) { create(:news_item, representative_id: representative_id) }

        it 'returns the news item' do
          expect(NewsItem.find_for(representative_id)).to eq(news_item)
        end
      end

      context 'when news item does not exist for given representative_id' do
        it 'returns nil' do
          expect(NewsItem.find_for(representative_id + 1)).to be_nil
        end
      end
    end
  end

  describe 'mocks and stubs' do
    let(:representative_id) { 1 }

    describe '.find_for' do
      context 'when news item exists for given representative_id' do
        let!(:news_item) { create(:news_item, representative_id: representative_id) }

        it 'returns the news item using a stub' do
          allow(NewsItem).to receive(:find_by).with(representative_id: representative_id).and_return(news_item)
          expect(NewsItem.find_for(representative_id)).to eq(news_item)
        end
      end

      context 'when news item does not exist for given representative_id' do
        it 'returns nil using a mock' do
          expect(NewsItem).to receive(:find_by).with(representative_id: representative_id + 1).and_return(nil)
          expect(NewsItem.find_for(representative_id + 1)).to be_nil
        end
      end
    end
  end
end
