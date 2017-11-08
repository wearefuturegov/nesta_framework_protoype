require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  
  describe 'POST create' do
    
    it 'creates a team with users' do
      user = FactoryBot.create(:user)
      post :create, params: {
        team: {
          users_attributes: {
            '0' => {
              email: 'bob@example.com'
            },
            '1' => {
              email: 'alice@example.com'
            },
            '2' => {
              email: user.email,
              id: user.id
            }
          }
        }
      }
            
      expect(Team.count).to eq(1)
      team = Team.last
      expect(team.users.count).to eq(3)
      expect(team.users[0].email).to eq('bob@example.com')
      expect(team.users[1].email).to eq('alice@example.com')
      expect(team.users[2].email).to eq(user.email)
      
      expect(User.count).to eq(3)
    end
    
  end
  
end
