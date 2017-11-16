require 'rails_helper'

RSpec.describe AssessmentsController, type: :controller do
  
  let(:areas) { FactoryBot.create_list(:area, 3) }
  
  describe 'GET index' do
    it 'renders the index template' do
      expect(get :index).to render_template(:index)
    end
    
    it 'gets areas' do
      get :index
      expect(assigns(:areas)).to eq(areas)
    end
    
    it 'sets the right step' do
      get :index
      expect(assigns(:step)).to eq(1)
    end
    
    context 'with a team id' do
      let(:users) {
        [
          FactoryBot.create(:user),
          FactoryBot.create(:user),
          FactoryBot.create(:user),
          FactoryBot.create(:user, :with_assessment),
          FactoryBot.create(:user, :with_assessment)
        ]
      }
      let(:team) {
          FactoryBot.create(:team, users: users)
      }
      
      let(:subject) { get :index, params: { team_id: team.id } }
      
      it 'gets the team' do
        subject
        expect(assigns(:team)).to eq(team)
      end
      
      it 'gets the assessments' do
        subject
        expect(assigns(:assessments).count).to eq(2)
      end
      
      it 'gets users without an assessment' do
        subject
        expect(assigns(:users_without_assessments).count).to eq(3)
      end
      
      it 'renders the correct template' do
        expect(subject).to render_template('teams/assessments')
      end
      
    end
  end
  
  describe 'GET new' do
    it 'renders the new template' do
      expect(get :new).to render_template(:new)
    end
    
    it 'gets areas' do
      get :new
      expect(assigns(:areas)).to eq(areas)
    end
    
    it 'sets the right step' do
      get :new
      expect(assigns(:step)).to eq(2)
    end
  end
  
  describe 'PUT create' do
    it 'creates an assessment' do
      expect { put :create }.to change { Assessment.count }.by(1)
    end
    
    it 'redirects to edit' do
      expect(put :create).to redirect_to(edit_assessment_url(Assessment.last))
    end
    
    it 'sets the right state' do
      put :create
      expect(Assessment.last.aasm_state).to eq('start')
    end
  end
  
  describe 'GET edit' do
    
    let(:assessment) { FactoryBot.create(:assessment) }
    let(:subject) { get :edit, params: { id: assessment } }
    
    {
      start: {
        template: :strong_skills,
        count: 3
      },
      strong_skills_added: {
        template: :weak_skills,
        count: 4
      },
      weak_skills_added: {
        template: :strong_attitudes,
        count: 5
      },
      strong_attitudes_added: {
        template: :weak_attitudes,
        count: 6
      },
      weak_attitudes_added: {
        template: :user,
        count: 7
      }
    }.each do |state, attrs|
      
      context "with #{state} state" do
        
        before do
          assessment.update_column(:aasm_state, state)
        end
        
        it 'renders the correct template' do
          expect(subject).to render_template(attrs[:template])
        end
        
        it 'sets the right step' do
          subject
          expect(assigns(:step)).to eq(attrs[:count])
        end
        
      end
      
    end
    
  end
  
  describe 'PUT update' do
    
    let(:assessment) { FactoryBot.create(:assessment) }
    let(:params) {
      {
         id: assessment,
         assessment: {}
       }
    }
    
    it 'updates strong skills' do
      params[:assessment][:strong_skills] = FactoryBot.create_list(:skill, 5)
      put :update, params: params
      assessment.reload
      expect(assessment.strong_skills.count).to eq(5)
    end
    
    it 'updates strong skills' do
      assessment.update_column(:aasm_state, 'strong_skills_added')
      params[:assessment][:weak_skills] = FactoryBot.create_list(:skill, 2)
      put :update, params: params
      assessment.reload
      expect(assessment.weak_skills.count).to eq(2)
    end
    
    it 'updates strong attitudes' do
      assessment.update_column(:aasm_state, 'weak_skills_added')
      params[:assessment][:strong_attitudes] = FactoryBot.create_list(:attitude, 3)
      put :update, params: params
      assessment.reload
      expect(assessment.strong_attitudes.count).to eq(3)
    end
    
    it 'updates weak attitudes' do
      assessment.update_column(:aasm_state, 'strong_attitudes_added')
      params[:assessment][:weak_attitudes] = FactoryBot.create_list(:attitude, 1)
      put :update, params: params
      assessment.reload
      expect(assessment.weak_attitudes.count).to eq(1)
    end
    
    it 'goes back' do
      assessment.update_column(:aasm_state, 'strong_attitudes_added')
      params[:back] = 1
      put :update, params: params
      assessment.reload
      expect(assessment.aasm_state).to eq('weak_skills_added')
    end
    
  end
  
end
