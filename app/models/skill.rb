class Skill < ApplicationRecord
  belongs_to :area
  has_many :assessment_answer
  has_many :behaviours
end
