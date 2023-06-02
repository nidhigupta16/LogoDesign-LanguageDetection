FactoryBot.define do
    factory :language do
      name { Faker::Nation.language }
    end
  end