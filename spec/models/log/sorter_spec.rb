require 'rails_helper'

RSpec.describe Log::Parser do
  it '#sort_by_date' do
    first = Log.create timestamp: Time.current - 1.day
    now = Log.create timestamp: Time.current
    last = Log.create timestamp: Time.current + 1.hour
    logs = [first, now, last].shuffle

    expect(Log::Sorter.sort_by_date(logs)).to eq([last, now, first])
  end
end
