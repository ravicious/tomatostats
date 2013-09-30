require "spec_helper"

feature "Managing Pomodoros" do
  background do
    sign_in
    import_pomodoros("#{Rails.root}/spec/support/clockwork_tomato.csv")
    click_link "Pomodoros"
  end

  scenario "Assigning pomodoros to a project" do
    create_project name: "Twerking Hard"

    check_first_three_pomodoros

    select "Twerking Hard", from: "Project"
    click_button "Assign"

    expect(page).to have_css('.pomodoros .pomodoro', text: "Twerking Hard")
  end

  context "with JavaScript enabled", js: true do
    scenario "Assigning pomodoros to a project" do
      create_project name: "Twerking Hard"

      visit pomodoros_path
      page.execute_script("$('#calendar').fullCalendar('gotoDate', new Date(1379504450*1000))")
      page.execute_script("$('#calendar').fullCalendar('select', new Date(1379504450*1000), new Date(1379522410*1000), false)")

      select "Twerking Hard", from: "Project"
      click_button "Assign"

      page.execute_script("$('#calendar').fullCalendar('gotoDate', new Date(1379504450*1000))")
      expect(page).to have_css('#calendar', text: "Twerking Hard")
    end
  end

  # context "using 24-hour clock format" do
  #   background { set_clock_format(24) }

  #   scenario "Pomodoros times" do
  #     expect(page).to have_text "10:00"
  #     expect(page).to have_text "10:30"

  #     expect(page).to have_text "19:00"
  #     expect(page).to have_text "19:30"
  #   end
  # end

  # context "using 12-hour clock format" do
  #   background { set_clock_format(12) }

  #   scenario "Pomodoro times" do
  #     expect(page).to have_text "10:00 AM"
  #     expect(page).to have_text "10:30 AM"

  #     expect(page).to have_text "7:00 PM"
  #     expect(page).to have_text "7:30 PM"
  #   end
  # end

  scenario "Displaying statistics" do
    expect(page).to have_text "5 pomodoros this week"
    expect(page).to have_text "10 pomodoros this month"
    expect(page).to have_text "15 pomodoros in overall"
  end

  scenario "Deleting pomodoros" do
    check_first_three_pomodoros
    click_button "Delete pomodoros"

    expect(page).to have_text "3 pomodoros deleted."
    expect(page).to have_css(".pomodoros tr", count: 12)
  end

  # context "with JavaScript enabled", js: true do
  #   scenario "Show duration stats" do
  #     expect(page).to have_text("about 2 hours")
  #     expect(page).to have_text("about 4 hours")
  #     expect(page).to have_text("about 6 hours")
  #   end
  # end
end
