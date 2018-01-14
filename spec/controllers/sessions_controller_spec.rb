require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  it "#new" do
    get :new
    expect(response).to render_template :new
  end

  describe "#create" do

    it "redirects to dashboard if password is correct" do
      post :create, params: { password: Rails.application.secrets.dashboard_password }
      expect(response).to redirect_to root_path
    end

    it "renders login template if password is wrong" do
      post :create, params: { password: 'wrong-password' }
      expect(response).to render_template :new
    end
  end
end
