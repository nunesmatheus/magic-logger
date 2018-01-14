require 'rails_helper'

RSpec.describe "pages/index.html.erb", type: :view do
  let!(:logs) { build_stubbed_list(:log, 45) }

  xit "Lists paginated logs" do
    assign :query_params, {}
    assign :logs, logs
    render
    per_page = Kaminari.default_per_page
    expect(rendered.count('<li')).to eq(per_page)
  end
end
