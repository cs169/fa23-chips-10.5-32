# frozen_string_literal: true

class Official
  attr_accessor :name, :address, :party, :photo_url

  def initialize(name, address, party, photo_url)
    @name = name
    @address = address
    @party = party
    @photo_url = photo_url
  end
end