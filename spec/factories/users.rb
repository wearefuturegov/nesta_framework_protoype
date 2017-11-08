FactoryBot.define do
  factory :user do
    email 'me@example.com'
    name 'Me'
    organisation_type 'Federal Government'
    position 'Management'
    location 'GB'
    
    trait :without_details do
      name nil
      organisation_type nil
      position nil
      location nil
    end
  end
end
