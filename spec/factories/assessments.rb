FactoryBot.define do
  factory :assessment do
    trait :valid do
      strong_skills { FactoryBot.create_list(:skill, 5) }
      weak_skills { FactoryBot.create_list(:skill, 2) }
      strong_attitudes { FactoryBot.create_list(:attitude, 3) }
      weak_attitudes { FactoryBot.create_list(:attitude, 1) }
    end
  end
end
