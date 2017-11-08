module ApplicationHelper

  def assessment_chart(assessment)
    pie_chart assessment_data(assessment), library: {
      chart: {
        backgroundColor: "#F4F3F4"
      }
    }
  end
  
  def assessment_data(assessment)
    assessment.strong_skills.inject(Hash.new(0)) { |h, e| h[e.skill.area.name] += 1 ; h }
  end

end
