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
  
end
