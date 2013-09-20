require "spec_helper"

shared_examples "an importer" do
  let(:user) { create(:user) }
  subject { described_class.new(input: file, user: user) }

  context "given a valid file" do
    describe "#import" do
      it "assigns pomodoros to a user" do
        expect{ subject.import }.to change(user.pomodoros, :count)
      end
    end

    describe "#imported_pomodoros" do
      before { subject.import }

      it "returns a list of imported pomodoros" do
        expect(subject).to have_at_least(1).imported_pomodoros
      end
    end
  end


  context "given an invalid file" do
    let(:file) { invalid_file }

    it "doesn't import any pomodoros" do
      expect{ subject.import }.not_to change(subject, :imported_pomodoros)
    end
  end

end

describe ClockworkTomatoImporter do
  let(:file) { "#{Rails.root}/spec/support/clockwork_tomato.csv" }
  let(:invalid_file) { "#{Rails.root}/spec/support/clockwork_tomato_invalid.csv" }

  it_behaves_like "an importer"
end
