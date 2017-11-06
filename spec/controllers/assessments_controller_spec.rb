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
  end
  
  describe 'GET new' do
    it 'renders the new template' do
      expect(get :new).to render_template(:new)
    end
    
    it 'gets areas' do
      get :new
      expect(assigns(:areas)).to eq(areas)
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
      start: :strong_skills,
      strong_skills_added: :weak_skills,
      weak_skills_added: :strong_attitudes,
      strong_attitudes_added: :weak_attitudes
    }.each do |state, template|
      
      context "with #{state} state" do
        
        before do
          assessment.update_column(:aasm_state, state)
        end
        
        it 'renders the correct template' do
          expect(subject).to render_template(template)
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
    
  end
  
  
end
