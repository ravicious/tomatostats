require 'spec_helper'

describe Project do
  context "when trying to make two projects with the same name" do
    context "by the same user" do
      let(:user) { create(:user) }

      before do
        2.times { create(:project, name: "Example project name", user: user) }
      end

      it "creates only one project" do
        expect(user).to have(1).project
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
end
