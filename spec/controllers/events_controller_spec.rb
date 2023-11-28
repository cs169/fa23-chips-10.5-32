# frozen_string_literal: true

require 'rails_helper'

describe EventsController do
  describe 'calling index' do
    before do
      county = County.new(
        name:       'Alameda',
        fips_code:  56,
        fips_class: 'C7'
      )
      new_state = State.create(
        name:         'California',
        fips_code:    6,
        symbol:       'CA',
        created_at:   Time.zone.now,
        updated_at:   Time.zone.now,
        is_territory: false,
        lat_min:      45,
        lat_max:      45,
        long_min:     45,
        long_max:     45
      )
      new_state.counties = [county]
      county.state = new_state
    end

    after do
      State.destroy_all
    end

    it 'calls index with filter-by parameter state-only' do
      get :index, params: { 'filter-by' => 'state-only', 'state' => 'CA', 'county' => 'Alameda' }
    end

    it 'calls index with filter-by parameter NOT state-only' do
      get :index, params: { 'filter-by' => 'county_and_state', 'state' => 'CA', 'county' => 'Alameda' }
    end
  end

  # describe 'calling show' do
  # it 'calls the show method' do
  #   county = County.new(
  #     name: 'Alameda',
  #     fips_code: 56,
  #     fips_class: "C7")
  #   event = Event.create(
  #     name: "Filler",
  #     county: county,
  #   )
  #   get :show, params: {:id => event.id}
  #   Event.destroy_all
  # end
  # end
end
# describe MoviesController do
#   describe 'searching TMDb' do
#     before :each do
#       @fake_results = [double('movie1'), double('movie2')]
#     end

#     # these are examples
#     it 'calls the model method that performs TMDb search' do
#       # RSpec for rails includes get method that simulates HTTP get
#       # hash argument = exact contents of params[] that your app would see
#       expect(Movie).to receive(:find_in_tmdb).with('hardware').and_return(@fake_results)
#       get :search_tmdb, {:search_terms => 'hardware'}
#     end

#     describe 'after valid search' do
#       before :each do
#         allow(Movie).to receive(:find_in_tmdb).and_return(@fake_results)
#         get :search_tmdb, {:search_terms => 'hardware'}
#       end

#       it 'selects the Search Results template for rendering' do
#         expect(response).to render_template('search_tmdb')
#       end
#       it 'makes the TMDb search results available to that template' do
#         expect(assigns(:movies)).to eq(@fake_results)
#       end
#     end
#   end
# end