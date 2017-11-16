require 'rails_helper'

RSpec.describe Assessment, type: :model do
  
  let(:strong_skills) { FactoryBot.create_list(:skill, 5) }
  let(:weak_skills) { FactoryBot.create_list(:skill, 2) }
  let(:strong_attitudes) { FactoryBot.create_list(:attitude, 3) }
  let(:weak_attitudes) { FactoryBot.create_list(:attitude, 1) }

  let(:assessment) {
    FactoryBot.create(:assessment,
      strong_skills: strong_skills,
      weak_skills: weak_skills,
      strong_attitudes: strong_attitudes,
      weak_attitudes: weak_attitudes,
      user: FactoryBot.create(:user)
    )
  }
  
  it 'creates strong skills' do
    expect(assessment.strong_skills.count).to eq(5)
    expect(assessment.strong_skills).to eq(strong_skills)
  end
  
  it 'creates weak skills' do
    expect(assessment.weak_skills.count).to eq(2)
    expect(assessment.weak_skills).to eq(weak_skills)
  end
  
  it 'creates stong attitudes' do
    expect(assessment.strong_attitudes.count).to eq(3)
    expect(assessment.strong_attitudes).to eq(strong_attitudes)
  end
  
  it 'creates weak attitudes' do
    expect(assessment.weak_attitudes.count).to eq(1)
    expect(assessment.weak_attitudes).to eq(weak_attitudes)
  end
  
  it 'has a user' do
    expect(assessment.user).to be_a(User)
  end
  
  it 'starts from scratch' do
    new_skills = FactoryBot.create_list(:skill, 5)
    assessment.strong_skills = new_skills
    expect(assessment.strong_skills.count).to eq(5)
    expect(assessment.strong_skills).to eq(new_skills)
  end
  
  context 'validations' do
    
    it 'is valid initially' do
      expect(assessment.valid?).to eq(true)
    end
    
    it 'gives an error for the wrong number of strong skills' do
      assessment.strong_skills = FactoryBot.create_list(:skill, 7)
      assessment.aasm_state = 'start'
      assessment.save
      assessment.valid?
      expect(assessment.errors.details[:strong_skills][0][:error]).to eq('You must choose 5 strong skills')
    end
    
    it 'gives an error for the wrong number of weak skills' do
      assessment.weak_skills = FactoryBot.create_list(:skill, 1)
      assessment.aasm_state = 'strong_skills_added'
      assessment.save
      assessment.valid?
      expect(assessment.errors.details[:weak_skills][0][:error]).to eq('You must choose 2 weak skills')
    end
    
    it 'gives an error for the wrong number of strong attitudes' do
      assessment.strong_attitudes = FactoryBot.create_list(:attitude, 5)
      assessment.aasm_state = 'weak_skills_added'
      assessment.save
      assessment.valid?
      expect(assessment.errors.details[:strong_attitudes][0][:error]).to eq('You must choose 3 strong attitudes')
    end
    
    it 'gives an error for the wrong number of weak attitudes' do
      assessment.weak_attitudes = FactoryBot.create_list(:attitude, 5)
      assessment.aasm_state = 'strong_attitudes_added'
      assessment.save
      assessment.valid?
      expect(assessment.errors.details[:weak_attitudes][0][:error]).to eq('You must choose 1 weak attitudes')
    end
    
    it 'cares not a jot for other states' do
      assessment.weak_attitudes = FactoryBot.create_list(:attitude, 5)
      assessment.aasm_state = 'complete'
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
      assessment.aasm_state = 'strong_attitudes_added'
      assessment.save
      expect(assessment.aasm_state).to eq('weak_attitudes_added')
    end
    
    it 'moves from weak_attitudes_added to complete' do
      assessment.aasm_state = 'weak_attitudes_added'
      assessment.save
      expect(assessment.aasm_state).to eq('complete')
    end
    
  end
  
  context 'grouping by area' do
    
    let(:area1) { FactoryBot.create(:area, name: 'area1') }
    let(:area2) { FactoryBot.create(:area, name: 'area2') }
    let(:area3) { FactoryBot.create(:area, name: 'area3') }
    let(:assessment) {
      FactoryBot.create(:assessment,
        strong_skills: [
          FactoryBot.create_list(:skill, 2, area: area1),
          FactoryBot.create_list(:skill, 1, area: area2),
          FactoryBot.create_list(:skill, 2, area: area3)
        ].flatten,
        weak_skills: [
          FactoryBot.create_list(:skill, 1, area: area1),
          FactoryBot.create_list(:skill, 1, area: area3)
        ].flatten
      )
    }
    
    it 'groups the strong areas' do
      expect(assessment.skills_by_area).to eq({
        'area1' => 2,
        'area2' => 1,
        'area3' => 2
      })
    end
    
    it 'groups the weak areas' do
      expect(assessment.skills_by_area(:weak_skills)).to eq({
        'area1' => 1,
        'area3' => 1
      })
    end
    
  end
  
  it 'sends an email when the assessment is complete' do
    assessment.aasm_state = 'weak_attitudes_added'
    expect { assessment.save }.to change { ActionMailer::Base.cached_deliveries.count }.by(1)
  end
  
  it 'does not send an email for any other state' do
    [
      'start',
      'strong_skills_added',
      'weak_skills_added',
      'strong_attitudes_added'
    ].each do |state|
      assessment.aasm_state = state
      expect { assessment.save }.to change { ActionMailer::Base.cached_deliveries.count }.by(0)
    end
  end
  
end
