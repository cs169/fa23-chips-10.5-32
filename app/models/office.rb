# frozen_string_literal: true

class Office
  attr_accessor :name, :division_id, :official_indices

  def initialize(name, division_id, official_indices)
    @name = name
    @division_id = division_id
    @official_indices = official_indices
  end
end