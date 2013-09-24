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

def check_first_three_pomodoros
  within '.pomodoros' do
    3.times do |n|
      find(:xpath, "(//input[@type='checkbox'])[#{n+1}]").set(true)
    end
  end
end

def assign_pomodoros_to_a_project(project: "Doesn't matter")
  visit pomodoros_path
  check_first_three_pomodoros
  select project, from: "Project"
  click_button "Assign"
end

def create_project(name: "Doesn't matter")
  visit '/' if current_path != "/"
  click_link "Add project"
  fill_in "Name", with: name
  click_button "Create Project"
end
