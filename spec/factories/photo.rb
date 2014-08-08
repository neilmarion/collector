# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    photo "random photo"
    sequence(:fb_id) { |n| "#{n}" }
  end
end
