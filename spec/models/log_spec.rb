require 'rails_helper'

RSpec.describe Log, type: :model do
  let(:log) { build(:log) }

  describe "#to_s" do
    it "joins all information in one line" do
      Log.relevant_attributes.each do |attribute|
        expect(log.to_s).to include attribute.to_s
        expect(log.to_s).to include log.send(attribute).to_s
      end
    end

    it "order information according to #attributes_order" do
      log_attributes = log.to_s.to_enum(:scan, /(\S+)=/).map do
        Regexp.last_match
      end.map { |m| m.to_s.sub('=', '') }

      expect(log_attributes - ['updated_at']).to eq Log.attributes_order
    end
  end
end