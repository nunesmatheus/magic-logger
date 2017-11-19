require 'rails_helper'

RSpec.describe Log::Searcher do
  let(:params) { { http_method: 'GET', status: 200, path: '/teste' } }

  describe "#search" do
  end

  describe "#query_from_params" do
    it "ignores blank values" do
      params[:http_method] = nil

      query_string = Log::Searcher.query_from_params params
      params.each do |key, value|
        if params[key].present?
          expect(query_string).to include key.to_s
        else
          expect(query_string).to_not include key.to_s
        end
      end
    end

    it "converts hash to string" do
      query_string = Log::Searcher.query_from_params params
      params.each do |key, value|
        expect(query_string).to include "#{key}:#{value}"
      end
    end
  end
end
