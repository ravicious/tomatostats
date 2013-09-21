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
      expect(page).to have_css(".pomodoros li", count: 13)
    end

    scenario "Importing new pomodoros" do
      import_pomodoros(file_with_old_pomodoros)
      import_pomodoros(file)

      expect(page).to have_css(".pomodoros li", count: 15)
    end

  end

  scenario "Two users uploading pomodoros that were done in the same time" do
    import_pomodoros(file)
    click_link "Sign out"

    sign_in(provider: "Google")
    import_pomodoros(file)

    expect(page).to have_css(".pomodoros li", count: 15)
  end

end
