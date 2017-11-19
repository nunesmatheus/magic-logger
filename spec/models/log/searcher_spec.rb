require 'rails_helper'

RSpec.describe Log::Searcher do
  let(:params) { { http_method: 'GET', status: 200, path: '/teste' } }

  describe "#search" do
    it "accepts special characters search" do
      build_list(:log, 10).map &:save
      log = build(:log, path: '/path').save
      Log.refresh_index!
      logs = Log::Searcher.search path: '/path'
      expect(logs.size).to eq(1)
      expect(logs.first['_id']).to eq(log['_id'])
    end
  end

  describe "#query_terms" do
    it "ignores blank values" do
      params[:http_method] = nil

      query_statements = Log::Searcher.query_terms(params)
      attributes = []
      query_statements.each do |statement|
        expect(statement[:term].keys.size).to eq(1)
        key = statement[:term].keys.first
        attributes << key
      end

      present_attributes = params.select { |key, value| value.present? }.keys
      ignored_attributes = params.select { |key, value| value.blank? }.keys

      present_attributes.each do |attribute|
        expect(attributes).to include attribute
      end

      ignored_attributes.each do |attribute|
        expect(attributes).to_not include attribute
      end
    end
  end
end
