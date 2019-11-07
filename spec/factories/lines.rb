FactoryBot.define do
  factory :line, class: LineRepository do
    name { Faker::Name.name }
    grade { '6c' }
    crag { Faker::Name.name }
    kind { 'boulder' }
  end
end
