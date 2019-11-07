FactoryBot.define do
  factory :ascent, class: AscentRepository do
    date { Date.new(2019, 10, 10) }
    belayer { Faker::Name.name }
    style { 'os' }
  end
end
