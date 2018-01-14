require 'rails_helper'

RSpec.describe "sessions/new.html.erb", type: :view do

  it "renders just one input, for password" do
    render
    expect(rendered).to include 'input'
    expect(rendered.scan('<input type="password"').size).to eq(1)
  end
end
