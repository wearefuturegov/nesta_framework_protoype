class Assessment < ApplicationRecord
  has_many :assessment_answers
    
  # This defines getters and setters for strong and weak skills and attitudes,
  # the setter sets assesssment_answers with the correct skill or attitude
  # and type (strong or weak), and the getter searches for the assessment answers
  # with the a skill or attitude and the given type.
  def method_missing(m, *args, &block)
    match_data = m.match /(strong|weak)_(skills|attitudes)(=?)/
    if match_data && match_data.length >= 3
      if match_data[3] == '='
        set_answers(match_data[1], args[0])
      else
        get_answers(match_data[1], match_data[2])
      end
    else
      super
    end
  end
  
  def set_answers(type, answers)
    answers.each do |a|
      answer_type = a.class.to_s.downcase
      assessment_answers << AssessmentAnswer.new(
        "#{answer_type}" => a,
        answer_type: type
      )
    end
  end
  
  def get_answers(answer_type, answer_class)
    column_name = get_column_name(answer_class)
    assessment_answers.where("#{column_name} IS NOT NULL AND answer_type = ?", answer_type)
  end
  
  def get_column_name(answer_class)
    raise Exception unless ['skills', 'attitudes'].include? answer_class
    Assessment.connection.quote_column_name("#{answer_class.singularize}_id")
  end

end
