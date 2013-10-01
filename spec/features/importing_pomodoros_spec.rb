require "spec_helper"

feature "Importing Pomodoros" do
  let(:file) { "#{Rails.root}/spec/support/clockwork_tomato.csv" }
  let(:file_with_old_pomodoros) { "#{Rails.root}/spec/support/clockwork_tomato_old.csv" }

  background do
    sign_in
  end

  context "from Clockwork Tomato" do

    scenario "Importing pomodoros from an export file", js: true do
      import_pomodoros(file_with_old_pomodoros)
      expect(page).to have_text("13 pomodoros imported.")

      import_pomodoros(file)
      expect(page).to have_text("2 pomodoros imported.")
      expect(page).to have_text("15 pomodoros in overall")
      FullCalendar.go_to_date 1379504450
      expect(page).to have_css(".fc-event-time", count: 5)
    end

  end

  scenario "Two users uploading pomodoros that were done in the same time", js: true do
    import_pomodoros(file)

    logout(:user)
    sign_in

    import_pomodoros(file)

    FullCalendar.go_to_date 1379504450
    expect(page).to have_css(".fc-event-time", count: 5)
  end

end
