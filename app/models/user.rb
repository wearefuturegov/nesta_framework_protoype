class User < ApplicationRecord
  has_one :assessment
  belongs_to :team, optional: true
  after_save :send_email, if: Proc.new { |u| u.can_send_email? }
  
  ORGANISATION_TYPES = [
    'Multi-national Government',
    'Federal Government',
    'Regional Government',
    'Local Government',
    'Other'
  ]
  
  POSTIONS = [
    'Executive',
    'Management',
    'Project delivery',
    'Other'
  ]
  
  COUNTRIES = ISO3166::Country.codes
  
  validates :email, email: true
  
  def can_send_email?
    !assessment.nil? && assessment.complete?
  end
  
  private
    
    def email_sent?
      email_sent === true
    end
  
    def send_email
      SendEmail.enqueue('UserMailer', :send_results, id)
    end
  
end
