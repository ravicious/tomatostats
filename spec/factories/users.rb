# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "Example user name ##{n}"}
    sequence(:uid) {|n| 10*n}
    provider 'facebook'
  end
end
