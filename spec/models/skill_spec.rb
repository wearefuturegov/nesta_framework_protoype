require 'rails_helper'

RSpec.describe Skill, type: :model do
  
  let(:area) { FactoryBot.create(:area) }
  let(:skill) {
    FactoryBot.create(:skill,
      name: 'Some Name',
      description: 'Description goes here',
      area: area
    )
  }
  
  it 'has a name' do
    expect(skill.name).to eq('Some Name')
  end
  
  it 'has a description' do
    expect(skill.description).to eq('Description goes here')
  end
  
  it 'has an area' do
    expect(skill.area).to eq(area)
  end
  
  it 'allows behaviours to be specified' do
    skill.behaviours << FactoryBot.create_list(:behaviour, 3)
    skill.save
    skill.reload
    expect(skill.behaviours.count).to eq(3)
  end
  
end
