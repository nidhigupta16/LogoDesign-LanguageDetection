FactoryBot.define do
  factory :logo_design do
    user {FactoryBot.create(:user)}
    filesize { 1 }
    filename { "MyString" }
    is_active { false }
  end
end
