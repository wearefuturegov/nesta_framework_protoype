require 'rails_helper'

RSpec.describe Attitude, type: :model do
  
  let(:attitude) { FactoryBot.create(:attitude, name: 'Attitude Name', description: 'Some description') }
  
  it 'has a name' do
    expect(attitude.name).to eq('Attitude Name')
  end
  
  it 'has a description' do
    expect(attitude.description).to eq('Some description')
  end
  
end
