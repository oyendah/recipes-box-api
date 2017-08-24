FactoryGirl.define do
  factory :user_new do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    user_name { Faker::StarWars.character }
    email 'user_new@email.com'
    password 'users'
    profile_pic nil
    bio { Faker::Lorem.sentence }
  end
end
