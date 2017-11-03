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
  
  
end
