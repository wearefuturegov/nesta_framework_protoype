class Assessment < ApplicationRecord
  has_and_belongs_to_many :areas
  has_and_belongs_to_many :attitudes

end
