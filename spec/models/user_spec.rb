require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user) {
    FactoryBot.create(:user,
      email: 'me@example.com',
      name: 'Me',
      organisation_type: 'Federal Government',
      position: 'Management',
      location: 'GB'
    )
  }
  
  describe '#self' do
    
    it 'has a list of organisation types' do
      expect(User::ORGANISATION_TYPES).to eq([
        'Multi-national Government',
        'Federal Government',
        'Regional Government',
        'Local Government',
        'Other'
      ])
    end
    
    it 'has a list of positions' do
      expect(User::POSTIONS).to eq([
        'Executive',
        'Management',
        'Project delivery',
        'Other'
      ])
    end
    
    it 'has a list of countries' do
      expect(User::COUNTRIES).to eq(ISO3166::Country.codes)
    end
    
  end
  
  it 'has an email' do
    expect(user.email).to eq('me@example.com')
  end
  
  it 'has a name' do
    expect(user.name).to eq('Me')
  end
  
  it 'has an organisation_type' do
    expect(user.organisation_type).to eq('Federal Government')
  end
  
  it 'has a position' do
    expect(user.position).to eq('Management')
  end
  
  it 'has a location' do
    expect(user.location).to eq('GB')
  end
  
  context 'invalid record' do
    
    let(:user) {
      FactoryBot.build(:user,
        email: 'dfsfdsfs',
        name: 'Me',
        organisation_type: 'Not This',
        position: 'Pen Pusher',
        location: 'Sealand'
      )
    }
    let(:messages) {
      user.valid?
      user.errors.messages
    }
    
    before do
      user.valid?
    end
    
    it 'is invalid' do
      expect(user.valid?).to be_falsey
    end
    
    it 'has an error for the email' do
      expect(messages[:email]).to eq(['is invalid'])
    end
    
    it 'has an error for the organisation_type' do
      expect(messages[:organisation_type]).to eq(['is not included in the list'])
    end
    
    it 'has an error for the position' do
      expect(messages[:position]).to eq(['is not included in the list'])
    end
    
    it 'has an error for the location' do
      expect(messages[:location]).to eq(['is not included in the list'])
    end
    
  end
  
  
end
