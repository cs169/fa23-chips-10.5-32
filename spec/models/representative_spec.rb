require 'rails_helper'
require 'spec_helper'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    it 'skips creation for existing representatives' do
      # Creating rep_info 
      rep_info = double('rep_info', officials: [
        double('official1', name: 'Andy Ngo'),
        double('official2', name: 'Josh Kim')
      ], offices: [
        double('office1', name: 'Mayor', division_id: 'ocdid1', official_indices: [0]),
        double('office2', name: 'Governor', division_id: 'ocdid2', official_indices: [1])
      ])
      # Create representative Andy
      existing_rep = Representative.create!(name: 'Andy Ngo', ocdid: 'ocdid1', title: 'Mayor')

      # Ensure that Representative.create! is not called for existing Andy
      expect(Representative).not_to receive(:create!).with({ name: 'Andy Ngo', ocdid: 'ocdid1', title: 'Mayor' })
      expect(Representative).to receive(:create!).with({ name: 'Josh Kim', ocdid: 'ocdid2', title: 'Governor' })
      # Call the method being tested
      Representative.civic_api_to_representative_params(rep_info)
    end
  end
end