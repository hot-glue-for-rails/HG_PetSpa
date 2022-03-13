FactoryBot.define do
  factory :appointment do
    when_at { "2022-03-13 10:03:21" }
    pet_id { 1 }
  end
end
