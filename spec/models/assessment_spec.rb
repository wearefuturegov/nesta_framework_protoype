require 'rails_helper'

RSpec.describe Assessment, type: :model do
  
  let(:assesment) {
    FactoryBot.create(:assessment,
      areas: FactoryBot.create_list(:area, 4),
      attitudes: FactoryBot.create_list(:attitude, 2)
    )
  }
  
  it 'creates the right number of areas' do
    expect(assesment.areas.count).to eq(4)
  end
  
  it 'creates the right number of attitudes' do
    expect(assesment.attitudes.count).to eq(2)
  end
  
end
