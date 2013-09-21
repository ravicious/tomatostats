require "spec_helper"

feature "Managing Projects" do
  background do
    sign_in
    import_pomodoros("#{Rails.root}/spec/support/clockwork_tomato.csv")
  end

  scenario "Creating a project" do
    click_link "Add project"
    fill_in "Name", with: "Awesome Project"
    click_button "Add project"

    expect(page).to have_text("Awesome Project")
    expect(page.path).to eq(root_path)
  end

  scenario "Assigning pomodoros to a project" do
    create_project "Twerking Hard"

    # TODO Inspect pomodoro checkboxes
    check('pomodoro')

    select "Twerking Hard", from: "Project"
    click_button "Assign"

    click_link "Twerking Hard"
    expect(page).to have_text("5 pomodoros this week")
    expect(page).to have_css(".pomodoros li", count: 5)
  end
end
