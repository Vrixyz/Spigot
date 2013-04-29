FactoryGirl.define do
  factory :user do
    name      "titi"
    email     "titi@example.com"
    password  "foobar"
    password_confirmation "foobar"
  end
end