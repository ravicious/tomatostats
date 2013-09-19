require "spec_helper"

feature "Viewing Pomodoros" do
  background do
    sign_in
    import_pomodoros("#{Rails.root}/spec/support/clockwork_tomato_new.csv")
  end

  scenario "Viewing pomodoros" do
    click_link "Pomodoros"

    context "using 24-hour clock format" do
      set_clock_format(24)

      expect(page).to have_text "10:00"
      expect(page).to have_text "10:30"

      expect(page).to have_text "19:00"
      expect(page).to have_text "19:30"
    end

    context "using 12-hour clock format" do
      set_clock_format(12)

      expect(page).to have_text "10:00 AM"
      expect(page).to have_text "10:30 AM"

      expect(page).to have_text "7:00 PM"
      expect(page).to have_text "7:30 PM"
    end

    expect(page).to have_text "5 pomodoros this week"
    expect(page).to have_text "10 pomodoros this month"
    expect(page).to have_text "15 pomodoros in overall"

    context "with JavaScript enabled", js: true do
      expect(page).to have_text("about 2 hours")
      expect(page).to have_text("about 4 hours")
      expect(page).to have_text("about 6 hours")
    end
  end
end
