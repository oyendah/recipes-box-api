FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    user_name { Faker::StarWars.character }
    email 'user@email.com'
    password 'users'
    profile_pic nil
    bio { Faker::Lorem.sentence }
  end
end
