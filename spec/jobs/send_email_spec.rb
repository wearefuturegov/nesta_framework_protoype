require 'rails_helper'

describe SendEmail, type: :model do
  
  it 'sends an email' do
    user = FactoryBot.create(:user)
    expect(UserMailer).to receive(:assessment_invite).with(user.id) {
      double(UserMailer, deliver_now!: true)
    }
    SendEmail.run('UserMailer', :assessment_invite, user.id)
  end
  
end
