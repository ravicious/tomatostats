require "spec_helper"

feature "Importing Pomodoros" do
  let(:file) { "#{Rails.root}/spec/support/clockwork_tomato.csv" }
  let(:file_with_old_pomodoros) { "#{Rails.root}/spec/support/clockwork_tomato_old.csv" }
  let(:too_big_file) { "#{Rails.root}/spec/support/clockwork_tomato_too_big.csv" }

  background do
    sign_in
  end

  context "from Clockwork Tomato" do

    scenario "Importing pomodoros from an export file", js: true do
      import_pomodoros(file_with_old_pomodoros)
      expect(page).to have_text("13 pomodoros imported.")

      import_pomodoros(file)
      expect(page).to have_text("2 pomodoros imported.")
      FullCalendar.go_to_date 1379504450
      expect(page).to have_css(".fc-event-time", count: 5)
    end

    scenario "Importing too big file" do
      import_pomodoros(too_big_file)
      expect(page).to have_text("File size is too big")
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
