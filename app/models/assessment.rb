class Assessment < ApplicationRecord
  include AASM
  
  after_update :transition_state

  aasm do
    state :start, initial: true
    state :strong_skills_added
    state :weak_skills_added
    state :strong_attitudes_added
    state :weak_attitudes_added
    state :complete
    
    event :add_strong_skills do
      transitions from: :start, to: :strong_skills_added
    end

    event :add_weak_skills do
      transitions from: :strong_skills_added, to: :weak_skills_added
    end
    
    event :add_strong_attitudes do
      transitions from: :weak_skills_added, to: :strong_attitudes_added
    end
    
    event :add_weak_attitudes do
      transitions from: :strong_attitudes_added, to: :weak_attitudes_added
    end
    
    event :complete do
      transitions from: :weak_attitudes_added, to: :complete
    end
  end
  
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
      if strong_skills.count > 0 && strong_skills.count != STRONG_SKILLS_COUNT
        errors.add(:strong_skills, "must be #{STRONG_SKILLS_COUNT}")
      end
    end
    
    def correct_number_of_weak_skills
      if weak_skills.count > 0 && weak_skills.count != WEAK_SKILLS_COUNT
        errors.add(:weak_skills, "must be #{WEAK_SKILLS_COUNT}")
      end
    end
    
    def correct_number_of_strong_attitudes
      if strong_attitudes.count > 0 && strong_attitudes.count != STRONG_ATTITUDES_COUNT
        errors.add(:strong_attitudes, "must be #{STRONG_ATTITUDES_COUNT}")
      end
    end
    
    def correct_number_of_weak_attitudes
      if weak_attitudes.count > 0 && weak_attitudes.count != WEAK_ATTITUDES_COUNT
        errors.add(:weak_attitudes, "must be #{WEAK_ATTITUDES_COUNT}")
      end
    end
    
    def transition_state
      job = self.aasm.events.map(&:name).first
      self.send(job) unless job.nil?
    end

end
