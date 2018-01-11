require 'rails_helper'

RSpec.describe LogsController, type: :controller do

  describe "POST #create" do

    it "persists log" do
      logs = Log.count
      post :create, FactoryBot.build(:log_parser).raw_log
      Log.refresh_index!
      expect(Log.count).to be > logs
    end

    it "authentication" do
      raise Exception.new('Not implemented yet')
    end
  end
end
