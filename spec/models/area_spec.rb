require 'rails_helper'

RSpec.describe Area, type: :model do
  
  let(:area) { FactoryBot.create(:area, name: 'Area Name', description: 'Some description') }
  
  it 'has a name' do
    expect(area.name).to eq('Area Name')
  end
  
  it 'has a description' do
    expect(area.description).to eq('Some description')
  end
  
end
