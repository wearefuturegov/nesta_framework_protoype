class User < ApplicationRecord
  has_one :assessment
  
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
