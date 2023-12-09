# frozen_string_literal: true

class CampaignFinance < ApplicationRecord
  API_KEY = '9lcjslvwVjbqtX0KcQQ3W9rFm316caQQ2T89n4xA'

  def self.fetch_top_candidates(cycle, category)
    url = build_api_url(cycle, category)
    response = fetch_data_from_api(url)
    parse_response(response)
  end

  private
  def self.build_api_url(cycle, category)
    URI.parse("https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json")
  end

  def self.fetch_data_from_api(url)
    request = Net::HTTP::Get.new(url)
    request['X-API-Key'] = API_KEY

    Net::HTTP.start(url.hostname, url.port, use_ssl: url.scheme == 'https') do |http|
      http.request(request)
    end
  end

  def self.parse_response(response)
    cdata = JSON.parse(response.body)
    cdata['results']
  end
end