def sign_in
  visit '/'
  click_link "with Facebook"
end

def import_pomodoros(input)
  visit '/'
  click_link "Import pomodoros"
  attach_file "File", input
  select "Clockwork Tomato", from: "Application"
  click_button "Submit"
end
