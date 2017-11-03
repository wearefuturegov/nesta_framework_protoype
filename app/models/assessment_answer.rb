class AssessmentAnswer < ApplicationRecord
  belongs_to :attitude, optional: true
  belongs_to :skill, optional: true
  belongs_to :assessment
end
