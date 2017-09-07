FactoryGirl.define do
  factory :recipe do
    title { Faker::Lorem.sentence(3) }
    description { Faker::Lorem.sentence }
    ingredient { Faker::StarWars.character }
    time_to_cook '45 min'
    instruction { Faker::Lorem.paragraph(2) }
    number_of_serving 0
    user_id nil
    recipe_category nil
  end
end
