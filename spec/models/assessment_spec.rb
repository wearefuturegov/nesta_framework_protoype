require 'rails_helper'

RSpec.describe Assessment, type: :model do
  
  let(:assesment) {
    FactoryBot.create(:assessment,
      strong_skills: FactoryBot.create_list(:skill, 4),
      weak_skills: FactoryBot.create_list(:skill, 2),
      strong_attitudes: FactoryBot.create_list(:attitude, 3),
      weak_attitudes: FactoryBot.create_list(:attitude, 1),
    )
  }
  
  it 'creates stong skills' do
    expect(assesment.strong_skills.count).to eq(4)
  end
  
  it 'creates weak skills' do
    expect(assesment.weak_skills.count).to eq(2)
  end
  
  it 'creates stong attitudes' do
    expect(assesment.strong_attitudes.count).to eq(3)
  end
  
  it 'creates weak attitudes' do
    expect(assesment.weak_attitudes.count).to eq(1)
  end
  
  # it 'creates the right number of attitudes' do
  #   expect(assesment.strongest_attitudes.count).to eq(2)
  # end
  #
end
