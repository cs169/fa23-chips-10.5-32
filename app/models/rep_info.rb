# frozen_string_literal: true

class RepInfo
  attr_accessor :offices, :officials

  def initialize(officials, offices)
    @officials = officials
    @offices = offices
  end
end