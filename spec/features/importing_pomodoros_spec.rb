require "spec_helper"

feature "Importing Pomodoros" do

  background do
    sign_in
  end

  context "from Clockwork Tomato" do

    scenario "Importing pomodoros from an export file" do
      click_link "Import pomodoros"

      attach_file "File", "#{Rails.root}/spec/support/clockwork_tomato_old.csv"
      select "Clockwork Tomato", from: "Application"
      click_button "Submit"

      expect(page.path).to eq(root_path)
      expect(page).to have_css(".pomodoros li", count: 3)
    end

    scenario "Importing new pomodoros" do
      import_pomodoros("#{Rails.root}/spec/support/clockwork_tomato_old.csv")
      import_pomodoros("#{Rails.root}/spec/support/clockwork_tomato.csv")

      expect(page).to have_css(".pomodoros li", count: 5)
    end

  end

end
