require 'rails_helper'

RSpec.describe Assessment, type: :model do
  
  let(:assessment) {
    FactoryBot.create(:assessment,
      strong_skills: FactoryBot.create_list(:skill, 5),
      weak_skills: FactoryBot.create_list(:skill, 2),
      strong_attitudes: FactoryBot.create_list(:attitude, 3),
      weak_attitudes: FactoryBot.create_list(:attitude, 1),
    )
  }
  
  it 'creates stong skills' do
    expect(assessment.strong_skills.count).to eq(5)
  end
  
  it 'creates weak skills' do
    expect(assessment.weak_skills.count).to eq(2)
  end
  
  it 'creates stong attitudes' do
    expect(assessment.strong_attitudes.count).to eq(3)
  end
  
  it 'creates weak attitudes' do
    expect(assessment.weak_attitudes.count).to eq(1)
  end
  
  context 'validations' do
    
    it 'is valid initially' do
      expect(assessment.valid?).to eq(true)
    end
    
    it 'gives an error for the wrong number of strong skills' do
      assessment.aasm_state = 'start'
      assessment.strong_skills = FactoryBot.create_list(:skill, 7)
      assessment.save
      assessment.valid?
      expect(assessment.errors.details[:strong_skills][0][:error]).to eq('must be 5')
    end
    
    it 'gives an error for the wrong number of weak skills' do
      assessment.aasm_state = 'strong_skills_added'
      assessment.weak_skills = FactoryBot.create_list(:skill, 1)
      assessment.save
      assessment.valid?
      expect(assessment.errors.details[:weak_skills][0][:error]).to eq('must be 2')
    end
    
    it 'gives an error for the wrong number of strong attitudes' do
      assessment.aasm_state = 'weak_skills_added'
      assessment.strong_attitudes = FactoryBot.create_list(:attitude, 5)
      assessment.save
      assessment.valid?
      expect(assessment.errors.details[:strong_attitudes][0][:error]).to eq('must be 3')
    end
    
    it 'gives an error for the wrong number of weak attitudes' do
      assessment.aasm_state = 'strong_attitudes_added'
      assessment.weak_attitudes = FactoryBot.create_list(:attitude, 5)
      assessment.save
      assessment.valid?
      expect(assessment.errors.details[:weak_attitudes][0][:error]).to eq('must be 1')
    end
    
    it 'cares not a jot for other states' do
      assessment.aasm_state = 'complete'
      assessment.weak_attitudes = FactoryBot.create_list(:attitude, 5)
      assessment.save
      expect(assessment.valid?).to eq(true)
    end
    
  end
  
  context 'transitioning' do
    
    it 'moves from start to strong_skills_added' do
      expect(assessment.aasm_state).to eq('start')
      assessment.save
      expect(assessment.aasm_state).to eq('strong_skills_added')
    end
    
    it 'moves from strong_skills_added to weak_skills_added' do
      assessment.aasm_state = 'strong_skills_added'
      assessment.save
      expect(assessment.aasm_state).to eq('weak_skills_added')
    end
    
    it 'moves from weak_skills_added to strong_attitudes_added' do
      assessment.aasm_state = 'weak_skills_added'
      assessment.save
      expect(assessment.aasm_state).to eq('strong_attitudes_added')
    end
    
    it 'moves from strong_attitudes_added to weak_attitudes_added' do
      assessment.aasm_state = 'weak_skills_added'
      assessment.save
      expect(assessment.aasm_state).to eq('strong_attitudes_added')
    end
    
    it 'moves from weak_attitudes_added to complete' do
      assessment.aasm_state = 'weak_attitudes_added'
      assessment.save
      expect(assessment.aasm_state).to eq('complete')
    end
    
  end
  
end
