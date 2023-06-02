FactoryBot.define do
  factory :user, class: "User" do
    name { Faker::Name.name }
    # email { Faker::Internet.free_email }
    email {"demo@gmail.com"}
    password { BCrypt::Password.create("password1") }
  end
end
