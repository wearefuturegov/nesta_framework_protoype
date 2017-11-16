class UserMailer < ActionMailer::Base
  default from: 'from@example.com'

  def assessment_invite(user_id)
    @user = User.find(user_id)
    I18n.with_locale(@user.locale) do
      mail(
        to: @user.email,
        subject: I18n.t('user_mailer.assessment_invite.subject')
      )
    end
  end
  
  def send_results(user_id)
    @user = User.find(user_id)
    I18n.with_locale(@user.locale) do
      mail(
        to: @user.email,
        subject: I18n.t('user_mailer.send_results.subject')
      )
    end
  end
  
end
