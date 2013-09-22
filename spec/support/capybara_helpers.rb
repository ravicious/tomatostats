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
