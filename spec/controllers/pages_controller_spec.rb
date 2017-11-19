require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #index" do
    before(:example) do
      build_list(:log, 5).each &:save
      Log.refresh_index!
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assign @logs with elasticsearch Logs" do
      get :index
      expect(assigns(:logs)).to be_present
      expect(assigns(:logs).map(&:class).uniq).to eq([Log])
    end

    it "assign @logs sorted" do
      expect_any_instance_of(Log).to receive(:sorted)
      get :index
    end
  end

end