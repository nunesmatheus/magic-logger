require 'rails_helper'

RSpec.describe Log::Parser do
  
  let(:parser) { FactoryBot.build(:log_parser) }

  it "#timestamp" do
    expect(parser.timestamp).to be_a DateTime
  end

  describe "#initialize" do

    it "defines singleton methods for any attributes on log" do
      expect(parser.raw_log).to_not include 'something'
      new_parser = Log::Parser.new "#{parser.raw_log} something=anything"
      expect(new_parser.something).to eq('anything')
    end
  end
end
