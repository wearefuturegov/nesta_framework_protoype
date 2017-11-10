require 'rails_helper'

RSpec.describe Team, type: :model do
  
  let(:team_creator) { FactoryBot.create(:user, :with_assessment) }
  let(:team) {
    FactoryBot.create(:team, users: [team_creator] + FactoryBot.create_list(:user, 5))
  }
  
  it 'has many users' do
    expect(team.users.count).to eq(6)
  end
  
  it 'sends an email to users' do
    expect { team }.to change { ActionMailer::Base.deliveries.count }.by(5)
  end
  
  context 'grouping areas' do
    
    let(:area1) { FactoryBot.create(:area, name: 'area1') }
    let(:area2) { FactoryBot.create(:area, name: 'area2') }
    let(:area3) { FactoryBot.create(:area, name: 'area3') }
    
    before do
      team.users[0].assessment = FactoryBot.create(:assessment, :valid,
        strong_skills: [
          FactoryBot.create_list(:skill, 2, area: area1),
          FactoryBot.create_list(:skill, 1, area: area2),
          FactoryBot.create_list(:skill, 2, area: area3)
        ].flatten,
      )
      team.users[1].assessment = FactoryBot.create(:assessment, :valid,
        strong_skills: [
          FactoryBot.create_list(:skill, 1, area: area1),
          FactoryBot.create_list(:skill, 4, area: area2),
        ].flatten,
      )
    end
    
    it 'gets all the strong areas for a team' do
      expect(team.skills_by_area).to eq({
        'area1' => 3,
        'area2' => 5,
        'area3' => 2
      })
    end
    
  end
  
end
