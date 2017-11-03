require 'rails_helper'

RSpec.describe Assessment, type: :model do
  
  let(:assesment) {
    FactoryBot.create(:assessment,
      strong_skills: FactoryBot.create_list(:skill, 5),
      weak_skills: FactoryBot.create_list(:skill, 2),
      strong_attitudes: FactoryBot.create_list(:attitude, 3),
      weak_attitudes: FactoryBot.create_list(:attitude, 1),
    )
  }
  
  it 'creates stong skills' do
    expect(assesment.strong_skills.count).to eq(5)
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
  
  context 'with wrong counts' do
    
    let(:assessment) {
      FactoryBot.build(:assessment,
        strong_skills: FactoryBot.create_list(:skill, 7),
        weak_skills: FactoryBot.create_list(:skill, 1),
        strong_attitudes: FactoryBot.create_list(:attitude, 5),
        weak_attitudes: FactoryBot.create_list(:attitude, 7),
      )
    }
    
    before do
      assessment.valid?
    end
    
    it 'gives an error for the wrong number of strong skills' do
      assessment.valid?
      expect(assessment.errors.details[:strong_skills][0][:error]).to eq('must be 5')
    end
    
    it 'gives an error for the wrong number of weak skills' do
      expect(assessment.errors.details[:weak_skills][0][:error]).to eq('must be 2')
    end
    
    it 'gives an error for the wrong number of strong attitudes' do
      expect(assessment.errors.details[:strong_attitudes][0][:error]).to eq('must be 3')
    end
    
    it 'gives an error for the wrong number of weak attitudes' do
      expect(assessment.errors.details[:weak_attitudes][0][:error]).to eq('must be 1')
    end
    
  end
  
end
