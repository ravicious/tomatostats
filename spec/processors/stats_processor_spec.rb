require "spec_helper"
require 'yaml'

describe StatsProcessor::Stats do
  let(:arrays) { YAML::load_file("#{Rails.root}/spec/support/stats_dump.yml") }

  subject { described_class.new(*arrays).parse }

  it "calculates total number of pomodoros" do
    expect(subject.count).to eq(90)
  end

  it "makes one group per month" do
    expect(subject.months).to have(3).groups
  end

  it "makes one group per week" do
    subject.months.each do |month|
      expect(month.weeks).to have_at_least(4).groups
    end
  end

  it "makes one group per day" do
    subject.months.each do |month|
      month.weeks.each do |week|
        expect(week.days).to have_at_least(1).group
      end
    end
  end
end
