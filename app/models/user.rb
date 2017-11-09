class User < ApplicationRecord
  has_one :assessment
  belongs_to :team, optional: true
  belongs_to :assessment, optional: true
  
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
  
end
