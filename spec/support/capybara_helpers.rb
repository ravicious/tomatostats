def sign_in(provider: "Facebook")
  visit '/'
  click_link "with #{provider}"
end

def import_pomodoros(input)
  visit '/'
  click_link "Import pomodoros"
  attach_file "File", input
  select "Clockwork Tomato", from: "Application"
  click_button "Submit"
end
