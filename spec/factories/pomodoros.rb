# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pomodoro do
    sequence(:started_at) {|n| 1.day.ago.to_i + n*60*30}
    sequence(:finished_at) {|n| 1.day.ago.to_i + n*60*30 + 25*60}
  end
end
