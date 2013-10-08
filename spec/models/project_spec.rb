require 'spec_helper'

describe Project do
  context "when trying to make two projects with the same name" do
    context "by the same user" do
      let(:user) { create(:user) }
      let(:new_project) { build(:project, name: "Example project name", user: user) }

      before do
        create(:project, name: "Example project name", user: user)
      end

      it "makes the second project not valid" do
        expect(new_project).not_to be_valid
      end
    end

    context "by two different users" do
      before do
        2.times { create(:project, name: "Example project name") }
      end

      it "creates two projects" do
        expect(Project.count).to eq(2)
      end
    end
  end

  describe ".sorted_by_activity" do
    before do
      7.times { |n| create(:project, name: "Project ##{n+1}") }
      Project.first.touch
      Project.last.touch
    end

    subject { Project.sorted_by_activity.load }

    it "sorts projects by activity" do
      expect(subject.first).to eq(Project.last)
      expect(subject.second).to eq(Project.first)
      expect(subject).not_to include(Project.where(name: "Project #2"))
      expect(subject).not_to include(Project.where(name: "Project #3"))
    end

    it "returns five projects" do
      expect(subject).to have(5).projects
    end
  end
end
