require "spec_helper"

describe Pomodoro do
  subject { create(:pomodoro) }

  describe "duration" do
    let(:invalid_pomodoro) { build(:pomodoro, :too_long_duration) }

    it "can't be longer than 4 hours" do
      expect(invalid_pomodoro).not_to be_valid
    end
  end
end
