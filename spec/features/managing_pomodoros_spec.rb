require "spec_helper"

feature "Managing Pomodoros" do
  background do
    sign_in
    import_pomodoros("#{Rails.root}/spec/support/clockwork_tomato.csv")
    click_link "Pomodoros"
  end

  scenario "Assigning pomodoros to a project", js: true do
    create_project name: "Twerking Hard"

    visit pomodoros_path
    FullCalendar.go_to_date 1379504450
    FullCalendar.select 1379504450, 1379522410
    select "Twerking Hard", from: "Project"

    click_button "Assign"
    expect(page).to have_text "5 pomodoros assigned."
    expect(page).to have_css(".fc-event-time", count: 5, text: "Twerking Hard")
  end

  scenario "Unassign pomodoros from a project", js: true do
    create_project name: "Twerking Hard"
    assign_pomodoros_to_a_project project: "Twerking Hard"

    FullCalendar.go_to_date 1379504450
    FullCalendar.select 1379504450, 1379522410
    click_button "Unassign"

    expect(page).to have_text "5 pomodoros unassigned."
    expect(page).not_to have_css(".fc-event-time", count: 5, text: "Twerking Hard")
  end

  scenario "Deleting pomodoros", js: true do
    FullCalendar.go_to_date 1379504450
    FullCalendar.select 1379504450, 1379521410
    click_button "Delete pomodoros"

    expect(page).to have_text "4 pomodoros deleted."
    expect(page).to have_css(".fc-event-time", count: 1)
  end
end
