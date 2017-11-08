require 'rails_helper'

RSpec.describe Team, type: :model do
  
  let(:team) {
    FactoryBot.create(:team, users: FactoryBot.create_list(:user, 5))
  }
  
  it 'has many users' do
    expect(team.users.count).to eq(5)
  end
  
end
