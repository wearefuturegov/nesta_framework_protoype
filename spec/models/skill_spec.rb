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
  
end
