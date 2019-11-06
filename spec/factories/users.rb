FactoryBot.define do
  factory :user, class: UserRepository do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    date_of_birth { Faker::Date.birthday }
    hashed_pass { BCrypt::Password.create('password') }
  end
end
