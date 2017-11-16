require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  
  let(:user) { FactoryBot.create(:user, :with_assessment) }
  
  describe '#assessment_invite' do
    
    let(:mail) { UserMailer.assessment_invite(user.id) }
    let(:body) { Nokogiri::HTML(mail.body.encoded).text.squish }
    
    it 'renders the headers' do
      expect(mail.subject).to eq(I18n.t('user_mailer.assessment_invite.subject'))
      expect(mail.to).to eq([user.email])
    end
    
    it 'renders the body' do
      text = Nokogiri::HTML(I18n.t('user_mailer.assessment_invite.intro_html')).text.squish
      expect(body).to match(/#{text}/)
    end
  
  end
  
  describe '#send_results' do
    
    let(:mail) { UserMailer.send_results(user.id) }
    let(:body) { Nokogiri::HTML(mail.body.encoded).text.squish }
    
    it 'renders the headers' do
      expect(mail.subject).to eq(I18n.t('user_mailer.send_results.subject'))
      expect(mail.to).to eq([user.email])
    end
    
    it 'renders the body' do
      text = Nokogiri::HTML(
        I18n.t('user_mailer.send_results.intro_html', assessment_url: "http://example.org/assessments/#{user.assessment.id}")
      ).text.squish
      expect(body).to match(/#{text}/)
    end
  
  end
  
end
  
