require 'rails_helper'

RSpec.describe "pages/index.html.erb", type: :view do
  let!(:logs) { build_stubbed_list(:log, 45) }

  before(:example) do
    assign :query_params, {}
    assign :logs, logs
  end

  it "shows structured request data" do
    render
    expect(rendered).to include("<td>#{logs.sample.request_id}</td>")
    expect(rendered).to include("<td>#{logs.sample.http_method}</td>")
    expect(rendered).to include("<td>#{logs.sample.status}</td>")
    expect(rendered).to include("<td>#{logs.sample.host}</td>")
    expect(rendered).to include("<td>#{logs.sample.path}</td>")
    expect(rendered).to include("<td>#{logs.sample.fwd}</td>")
  end

  it "shows raw data when log is not in request format" do
    non_structured_data = 'some log with no structured data'
    non_structured_log = Log.new raw: non_structured_data
    assign :logs, logs + [non_structured_log]
    render
    expect(rendered).to include(non_structured_data)
  end

  xit "Lists paginated logs" do
    render
    per_page = Kaminari.default_per_page
    expect(rendered.count('<li')).to eq(per_page)
  end
end
