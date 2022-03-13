FactoryBot.define do
  factory :human do
    password {"password"}
    encrypted_password {"password"}
    email {FFaker::Internet.email}
  end
end
