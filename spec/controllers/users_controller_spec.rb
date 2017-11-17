require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  
  let(:user) { FactoryBot.create(:user) }
  
  describe 'GET start_assessment' do
    
    let(:subject) { get :start_assessment, params: { id: user.id } }
    
    it 'creates an assessment' do
      subject
      expect(Assessment.count).to eq(1)
      assessment = Assessment.last
      expect(assessment.user).to eq(user)
    end
    
    it 'redirects to the assessment' do
      expect(subject).to redirect_to(step_1_assessment_url(Assessment.last))
    end
    
  end
  
end
