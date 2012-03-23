FactoryGirl.define do
  sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :user do
    name "Jaime Rave"
    email
    mobile "3003160361"
    phone "3400868"
    twitter "@JaimeRave"
    facebook "facebook.com/jaimerave"
  end
end