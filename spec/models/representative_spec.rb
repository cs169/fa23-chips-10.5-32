require 'rails_helper'
require 'spec_helper'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    it 'skips creation for existing representatives' do
      # Creating rep_info 
      rep_info = double('rep_info', officials: [
        double('official1', name: 'Andy Ngo', party: 'Republican', address: { 'line1' => '123 Main St', 'city' => 'Anytown', 'state' => 'CA', 'zip' => '12345' }, photoUrl: 'https://example.com/andy_photo.jpg'),
        double('official2', name: 'Josh Kim', party: 'Democratic', address: { 'line1' => '456 Oak St', 'city' => 'Someville', 'state' => 'CA', 'zip' => '67890' }, photoUrl: 'https://example.com/josh_photo.jpg')
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
end