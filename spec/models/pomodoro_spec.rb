require "spec_helper"

describe Pomodoro do
  subject { create(:pomodoro) }

  describe "duration" do
    let(:invalid_pomodoro) { build(:pomodoro, :too_long_duration) }

    it "can't be longer than 1 hour" do
      expect(invalid_pomodoro).not_to be_valid
    end
  end

  describe ".stats" do
    before do
      # destroy that subject created before
      Pomodoro.destroy_all

      3.times { |m|
        30.times { |day_count|
          create(:pomodoro,
                 started_at: m.months.ago.beginning_of_month.to_i + day_count*86400 + 60*30,
                 finished_at: m.months.ago.beginning_of_month.to_i + day_count*86400 + 60*30 + 25*60
                )
        }
      }
    end

    subject { Pomodoro.stats }

    # four `expects` in one `it` in order to speed up tests
    it "calculates total number of pomodoos and makes one group per date range" do
      expect(subject['count']).to eq(90)

      expect(subject['months']).to have(3).groups

      subject['months'].each_value do |month|
        expect(month['weeks']).to have_at_least(4).groups
      end

      subject['months'].each_value do |month|
        month['weeks'].each_value do |week|
          expect(week['days']).to have_at_least(1).group
        end
      end
    end
  end
end
