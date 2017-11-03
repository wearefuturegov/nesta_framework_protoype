FactoryBot.define do
  factory :skill do
    name "MyString"
    description "MyText"
    area { FactoryBot.create(:area) }
  end
end
