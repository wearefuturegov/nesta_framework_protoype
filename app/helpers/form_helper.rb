module FormHelper
  
  def setup_assessment(assessment)
    assessment.user ||= User.new
    assessment
  end
  
end
