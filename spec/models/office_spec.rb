# spec/models/office_spec.rb

require 'rails_helper'

RSpec.describe Office, type: :model do
  describe 'attributes' do
    let(:name) { 'Office Name' }
    let(:division_id) { 'division123' }
    let(:official_indices) { [0, 1, 2] }
    let(:office) { Office.new(name, division_id, official_indices) }

    it 'has a name' do
      expect(office.name).to eq(name)
    end

    it 'has a division ID' do
      expect(office.division_id).to eq(division_id)
    end

    it 'has official indices' do
      expect(office.official_indices).to eq(official_indices)
    end
  end
end
