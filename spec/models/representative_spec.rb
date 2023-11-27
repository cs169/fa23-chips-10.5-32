# spec/model/representative_spec.rb
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe 'Rep double behavior' do
    it 'skips creation for existing representatives' do
      # Creating rep_info 
      rep_info = double('rep_info', officials: [
        double('official1', name: 'Andy Ngo', party: 'Republican', address: { 'line1' => '123 Main St', 'city' => 'Anytown', 'state' => 'CA', 'zip' => '12345' }, photo_url: 'https://example.com/andy_photo.jpg'),
        double('official2', name: 'Josh Kim', party: 'Democratic', address: { 'line1' => '456 Oak St', 'city' => 'Someville', 'state' => 'CA', 'zip' => '67890' }, photo_url: 'https://example.com/josh_photo.jpg')
      ], offices: [
        double('office1', name: 'Mayor', division_id: 'ocdid1', official_indices: [0]),
        double('office2', name: 'Governor', division_id: 'ocdid2', official_indices: [1])
      ])
      # Create representative Andy
      existing_rep = Representative.create!(name: 'Andy Ngo', ocdid: 'ocdid1', title: 'Mayor')

      # Ensure that Representative.create! is not called for existing Andy
      expect(Representative).not_to receive(:create!).with({
        name: 'Andy Ngo',
        ocdid: 'ocdid1',
        title: 'Mayor',
        contact_address: '123 Main St, Anytown, CA 12345',
        political_party: 'Republican',
        photo_url: 'https://example.com/andy_photo.jpg'
      })

      expect(Representative).to receive(:create!).with({
        name: 'Josh Kim',
        ocdid: 'ocdid2',
        title: 'Governor',
        contact_address: '456 Oak St, Someville, CA 67890',
        political_party: 'Democratic',
        photo_url: 'https://example.com/josh_photo.jpg'
      })

      # Call the method being tested
      Representative.civic_api_to_representative_params(rep_info)
    end
  end
  describe 'Creating representatives' do
    andy_data = RepInfo.new([Official.new('Andy Ngo', { 'line1' => '123 Main St', 'city' => 'Anytown', 'state' => 'CA', 'zip' => '12345' }, 'Republican', 'https://example.com/andy_photo.jpg')], [Office.new('Mayor', 'ocdid1', [0])])
    josh_data = RepInfo.new([Official.new('Josh Kim', { 'line1' => '456 Oak St', 'city' => 'Someville', 'state' => 'CA', 'zip' => '67890' }, 'Democrat', 'https://example.com/josh_photo.jpg')], [Office.new('Governer', 'ocdid2', [1])])
    combined_data = RepInfo.new([Official.new('Andy Ngo', { 'line1' => '123 Main St', 'city' => 'Anytown', 'state' => 'CA', 'zip' => '12345' }, 'Republican', 'https://example.com/andy_photo.jpg'), Official.new('Josh Kim', { 'line1' => '456 Oak St', 'city' => 'Someville', 'state' => 'CA', 'zip' => '67890' }, 'Democrat', 'https://example.com/josh_photo.jpg')], [Office.new('Mayor', 'ocdid1', [0]), Office.new('Governer', 'ocdid2', [1])])
    invalid_data = []
    it 'returns nil when parameters are illegal' do
      rep = described_class.civic_api_to_representative_params(invalid_data)
      expect(rep).to eq([])
    end
    it 'creates a rep when it doesnt exist already' do
      rep = described_class.civic_api_to_representative_params(andy_data)
      expect(rep.count).to eq(1)
    end
    it 'creates 2 reps when they dont exist already' do
      rep = described_class.civic_api_to_representative_params(combined_data)
      expect(rep.count).to eq(2)
    end
    context 'when the representative already exists' do
      before do
        rep = described_class.create!(name: 'Andy Ngo', ocdid: 'ocdid1', title: 'Mayor')
      end
      it 'does not create a new representative' do
        rep = described_class.civic_api_to_representative_params(andy_data)
        expect(rep.count).to eq(0)
      end
      it 'creates a different representative' do
        rep = described_class.civic_api_to_representative_params(josh_data)
        expect(rep.count).to eq(1)
      end
      it 'creates some of the representative if some exist' do
        rep = described_class.civic_api_to_representative_params(combined_data)
        expect(rep.count).to eq(1)
      end
    end
  end
end