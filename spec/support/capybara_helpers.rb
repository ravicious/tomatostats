def sign_in
  user = create(:user)
  login_as user, scope: :user
  visit root_path
end

def import_pomodoros(input)
  visit '/'
  click_link "Import pomodoros"
  attach_file "File", input
  select "Clockwork Tomato", from: "Application"
  click_button "Submit"
end

def assign_pomodoros_to_a_project(project: "Doesn't matter")
  visit pomodoros_path
  FullCalendar.select 1379504450, 1379522410
  select project, from: "Project"
  click_button "Assign"
end

def create_project(name: "Doesn't matter")
  js_only {
    page.execute_script("$('.dropdown-toggle').eq(0).dropdown('toggle');")
  }
  click_link "Add project"
  fill_in "Name", with: name
  click_button "Create Project"
end

def js_only(&block)
  yield if using_javascript_driver?
end

def using_javascript_driver?
  Capybara.current_driver == Capybara.javascript_driver
end
