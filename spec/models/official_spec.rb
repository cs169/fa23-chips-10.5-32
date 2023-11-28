# spec/models/official_spec.rb

require 'rails_helper'

RSpec.describe Official, type: :model do
  describe 'attributes' do
    let(:name) { 'John Doe' }
    let(:address) { '123 Main St, City, Country' }
    let(:party) { 'Independent' }
    let(:photo_url) { 'http://example.com/photo.jpg' }
    let(:official) { Official.new(name, address, party, photo_url) }

    it 'has a name' do
      expect(official.name).to eq(name)
    end

    it 'has an address' do
      expect(official.address).to eq(address)
    end

    it 'has a party' do
      expect(official.party).to eq(party)
    end

    it 'has a photo URL' do
      expect(official.photo_url).to eq(photo_url)
    end
  end
end
