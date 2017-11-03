class Assessment < ApplicationRecord
  has_many :assessment_answers
  
  STRONG_SKILLS_COUNT = 5
  WEAK_SKILLS_COUNT = 2
  STRONG_ATTITUDES_COUNT = 3
  WEAK_ATTITUDES_COUNT = 1
  
  validate :correct_number_of_strong_skills
  validate :correct_number_of_weak_skills
  validate :correct_number_of_strong_attitudes
  validate :correct_number_of_weak_attitudes
  
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
    assessment_answers.select { |a| !a.send("#{answer_class.singularize}").nil? && a.answer_type == answer_type }
  end
  
  private
  
    def correct_number_of_strong_skills
      if strong_skills.count != STRONG_SKILLS_COUNT
        errors.add(:strong_skills, "must be #{STRONG_SKILLS_COUNT}")
      end
    end
    
    def correct_number_of_weak_skills
      if weak_skills.count != WEAK_SKILLS_COUNT
        errors.add(:weak_skills, "must be #{WEAK_SKILLS_COUNT}")
      end
    end
    
    def correct_number_of_strong_attitudes
      if strong_attitudes.count != STRONG_ATTITUDES_COUNT
        errors.add(:strong_attitudes, "must be #{STRONG_ATTITUDES_COUNT}")
      end
    end
    
    def correct_number_of_weak_attitudes
      if weak_attitudes.count != WEAK_ATTITUDES_COUNT
        errors.add(:weak_attitudes, "must be #{WEAK_ATTITUDES_COUNT}")
      end
    end

end
