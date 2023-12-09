# frozen_string_literal: true

class CampaignFinanceController < ApplicationController
  def index
    @campaign_finance = CampaignFinance.all
  end

  def search
    cycle = params[:cycle]
    category = params[:category]
    candidates = CampaignFinance.fetch_top_candidates(cycle, category)
    @data = candidates
    render 'campaign_finance/search'
  end
end