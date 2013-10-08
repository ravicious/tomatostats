require "spec_helper"

feature "Managing Projects" do
  let(:project_name) { "Awesome project, great job!" }
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

  scenario "Projects index" do
    7.times {|n| create_project(name: "Project ##{n+1}") }
    click_link "Projects"

    within('.panel .projects') do
      7.times do |n|
        expect(page).to have_text("Project ##{n+1}")
      end
    end
  end

  scenario "Project page" do
    create_project name: project_name
    click_link "Projects"
    within('.panel') do
      click_link project_name

      expect(page).to have_text(project_name)
    end
  end

  scenario "Editing a project" do
    create_project name: "My awesome project"
    click_link "Projects"
    within('.panel .projects') { click_link "My awesome project" }
    click_link "Edit"

    fill_in "Name", with: "My great project"
    click_button "Update Project"

    expect(page).to have_content("My great project")
  end

  scenario "Destroying a project", js: true do
    create_project name: project_name
    assign_pomodoros_to_a_project project: project_name

    click_link "Projects"
    click_link(project_name)
    click_link "Delete"
    visit pomodoros_path

    FullCalendar.go_to_date 1379504450
    within('#calendar') do
      expect(page).not_to have_content(project_name)
    end
  end
end
