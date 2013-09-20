require 'spec_helper'

describe EmptyImporter do
  let(:user) { create(:user) }
  subject { described_class.new(input: "not important", user: user) }

  it "doesn't import any pomodoros" do
    expect{ subject.import }.not_to change(subject, :imported_pomodoros)
  end
end
