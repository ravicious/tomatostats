require "spec_helper"

feature "Importing Pomodoros" do
  let(:file) { "#{Rails.root}/spec/support/clockwork_tomato.csv" }
  let(:file_with_old_pomodoros) { "#{Rails.root}/spec/support/clockwork_tomato_old.csv" }

  background do
    sign_in
  end

  context "from Clockwork Tomato" do

    scenario "Importing pomodoros from an export file" do
      click_link "Import pomodoros"

      attach_file "File", file_with_old_pomodoros
      select "Clockwork Tomato", from: "Application"
      click_button "Submit"

      expect(current_path).to eq(root_path)
      expect(page).to have_css(".pomodoros tr", count: 13)
    end

    scenario "Importing new pomodoros" do
      import_pomodoros(file_with_old_pomodoros)
      expect(page).to have_text("13 pomodoros imported.")

      import_pomodoros(file)
      expect(page).to have_text("2 pomodoros imported.")
      expect(page).to have_css(".pomodoros tr", count: 15)
    end

  end

  scenario "Two users uploading pomodoros that were done in the same time" do
    import_pomodoros(file)

    logout(:user)
    sign_in

    import_pomodoros(file)

    expect(page).to have_css(".pomodoros tr", count: 15)
  end

end
