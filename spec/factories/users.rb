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
    
    trait :with_assessment do
      assessment { FactoryBot.create(:assessment, :valid) }
    end
    
    trait :with_team do
      team { FactoryBot.create(:team) }
    end
  end
end
