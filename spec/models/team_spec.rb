require 'rails_helper'

RSpec.describe Team, type: :model do
  
  let(:team_creator) { FactoryBot.create(:user, :with_assessment) }
  let(:team) {
    FactoryBot.create(:team, users: FactoryBot.create_list(:user, 5) + [team_creator])
  }
  
  it 'has many users' do
    expect(team.users.count).to eq(6)
  end
  
  it 'sends an email to users' do
    expect { team }.to change { ActionMailer::Base.deliveries.count }.by(5)
  end
  
end
