require "spec_helper"

feature "Managing Projects" do
  background do
    sign_in
    import_pomodoros("#{Rails.root}/spec/support/clockwork_tomato.csv")
  end

  scenario "Creating a project" do
    click_link "Add project"
    fill_in "Name", with: "Awesome Project"
    click_button "Create Project"

    expect(page).to have_text("Awesome Project")
    expect(current_path).to eq(root_path)
  end

  scenario "Assigning pomodoros to a project" do
    create_project name: "Twerking Hard"

    check_first_three_pomodoros

    select "Twerking Hard", from: "Project"
    click_button "Assign"

    expect(page).to have_css('.pomodoros .pomodoro', text: "Twerking Hard")
  end

  scenario "Projects index" do
    7.times {|n| create_project(name: "Project ##{n+1}") }
    click_link "Projects"

    within('.projects') do
      7.times do |n|
        expect(page).to have_text("Project ##{n+1}")
      end
    end
  end
end
