# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.format_address(address)
    return '' unless address
    "#{address['line1']}, #{address['city']}, #{address['state']} #{address['zip']}"
  end

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      if !Representative.exists?(name: official.name)
        # rep = Representative.create!({ name: official.name, ocdid: ocdid_temp,
        #     title: title_temp })

        rep = Representative.create!({
          name: official.name,
          ocdid: ocdid_temp,
          title: title_temp,
          contact_address: format_address(official.address),
          political_party: official.party,
          photo_url: official.photoUrl
        })
        reps.push(rep)
      end
    end

    reps
  end
end
