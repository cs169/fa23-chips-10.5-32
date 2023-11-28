# spec/helpers/application_helper_spec.rb

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#state_ids_by_name' do
    it 'returns a hash of state names mapped to their IDs' do
      states = [double('State', name: 'State 1', id: 1), double('State', name: 'State 2', id: 2)]
      allow(State).to receive(:all).and_return(states)

      expect(ApplicationHelper.state_ids_by_name).to eq({ 'State 1' => 1, 'State 2' => 2 })
    end
  end

  describe '#state_symbols_by_name' do
    it 'returns a hash of state names mapped to their symbols' do
      states = [double('State', name: 'State 1', symbol: 'S1'), double('State', name: 'State 2', symbol: 'S2')]
      allow(State).to receive(:all).and_return(states)

      expect(ApplicationHelper.state_symbols_by_name).to eq({ 'State 1' => 'S1', 'State 2' => 'S2' })
    end
  end

  describe '#nav_items' do
    it 'returns an array of navigation items' do
      # Implementing a stub for Rails.application.routes.url_helpers methods
      allow(Rails.application.routes.url_helpers).to receive(:root_path).and_return('/')
      allow(Rails.application.routes.url_helpers).to receive(:events_path).and_return('/events')
      allow(Rails.application.routes.url_helpers).to receive(:representatives_path).and_return('/representatives')

      expect(ApplicationHelper.nav_items).to eq([
        { title: 'Home', link: '/' },
        { title: 'Events', link: '/events' },
        { title: 'Representatives', link: '/representatives' }
      ])
    end
  end

  describe '#active' do
    it 'returns the active class based on current controller name and nav link' do
      allow(Rails.application.routes).to receive(:recognize_path).and_return(controller: 'events')
      curr_controller_name = 'events'

      expect(ApplicationHelper.active(curr_controller_name, '/events')).to eq('bg-primary-active')
      expect(ApplicationHelper.active(curr_controller_name, '/representatives')).to eq('bg-primary-active')
    end
  end
end
