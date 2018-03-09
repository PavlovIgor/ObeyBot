FactoryGirl.define do
  factory :user do
    user_id 123
    is_bot false
    first_name "Igor"
    last_name "Pavlov"
    username "username"
    lang_code "ru"
    age 100
    gender "м"
    skill_level "с"
  end
end
