require "spec_helper"

shared_examples "an importer" do
  let(:user) { create(:user) }
  let(:importer) { described_class.instance }

  context "given a standard file" do
    it "assigns pomodoros to a user" do
      expect{ importer.import(file, user) }.to change(user, :pomodoros)
    end

    describe ".response" do
      subject { importer.import(file, user).response }

      it "returns success" do
        expect(subject.success?).to be_true
      end

      it "returns added pomodoros count" do
        expect(subject.pomodoros_added_count).not_to be_empty
      end
    end
  end


  context "given an invalid file" do
    let(:file) { "#{Rails.root}/spec/support/invalid_file" }

    describe ".response" do
      subject { importer.import(file, user).response }

      it "returns no success" do
        expect(subject.success?).to be_false
      end
    end
  end

end

describe ClockworkTomatoImporter do
  let(:file) { "#{Rails.root}/spec/support/clockwork_tomato.csv" }

  it_behaves_like "an importer"
end
