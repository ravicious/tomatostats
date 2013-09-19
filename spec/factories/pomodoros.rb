# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pomodoro do
    sequence(:started_at) {|n| 1.day.ago.to_i + n*60*30}
    sequence(:finished_at) {|n| 1.day.ago.to_i + n*60*30 + 25*60}

    trait(:too_long_duration) do
    sequence(:started_at) {|n| 1.day.ago.to_i + n*60*30}
    sequence(:finished_at) {|n| 1.day.ago.to_i + n*60*30 + 25*60 + 60*60*5}
    end
  end
end
