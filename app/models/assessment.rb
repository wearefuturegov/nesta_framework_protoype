class Assessment < ApplicationRecord
  INITAL_STATE = :start
  
  ASSESSMENT_STATES = [
    :start,
    :strong_skills_added,
    :weak_skills_added,
    :strong_attitudes_added,
    :weak_attitudes_added,
    :complete
  ]
  
  include AASM
  
  before_update :transition_state
  has_many :assessment_answers
  belongs_to :user, optional: true
  
  STRONG_SKILLS_COUNT = 5
  WEAK_SKILLS_COUNT = 2
  STRONG_ATTITUDES_COUNT = 3
  WEAK_ATTITUDES_COUNT = 1
  
  validate :check_answers, on: :update
  
  accepts_nested_attributes_for :user
  
  def strong_skills=(skills)
    set_answers('strong', 'skill', skills)
  end
  
  def weak_skills=(skills)
    set_answers('weak', 'skill', skills)
  end
  
  def strong_attitudes=(attitudes)
    set_answers('strong', 'attitude', attitudes)
  end
  
  def weak_attitudes=(attitudes)
    set_answers('weak', 'attitude', attitudes)
  end

  aasm do
    ASSESSMENT_STATES.each do |s|
      if s == INITAL_STATE
        state s, initial: true
      else
        state s
      end
    end
  end
  
  # This defines getters and setters for strong and weak skills and attitudes,
  # the setter sets assesssment_answers with the correct skill or attitude
  # and type (strong or weak), and the getter searches for the assessment answers
  # with the a skill or attitude and the given type.
  def method_missing(m, *args, &block)
    match_data = m.match /(strong|weak)_(skills|attitudes)/
    if match_data && match_data.length >= 3
      get_answers(match_data[1], match_data[2])
    else
      super
    end
  end
  
  def set_answers(type, answer_type, answers)
    answers.each do |a|
      assessment_answers << AssessmentAnswer.new(
        "#{answer_type}_id" => (a.try(:id) || a),
        answer_type: type
      )
    end
  end
  
  def get_answers(answer_type, answer_class)
    answers = answer_class == 'skills' ? skill_answers : attitude_answers
    answers.select { |a| a.answer_type == answer_type }
  end
  
  def skill_answers
    assessment_answers.select { |a| !a.skill.nil? }
  end
  
  def attitude_answers
    assessment_answers.select { |a| !a.attitude.nil? }
  end
  
  def get_user
    user.nil? ? User.new : user
  end
  
  def go_back
    transition_state(true)
  end
  
  private
  
    def check_answers
      if aasm_state == 'start'
        correct_number_of_strong_skills
      elsif aasm_state == 'strong_skills_added'
        correct_number_of_weak_skills
      elsif aasm_state == 'weak_skills_added'
        correct_number_of_strong_attitudes
      elsif aasm_state == 'strong_attitudes_added'
        correct_number_of_weak_attitudes
      end
    end
    
    def correct_number_of_strong_skills
      if strong_skills.count != STRONG_SKILLS_COUNT
        add_error :strong_skills, STRONG_SKILLS_COUNT
      end
    end
    
    def correct_number_of_weak_skills
      if weak_skills.count != WEAK_SKILLS_COUNT
        add_error :weak_skills, WEAK_SKILLS_COUNT
      end
    end
    
    def correct_number_of_strong_attitudes
      if strong_attitudes.count != STRONG_ATTITUDES_COUNT
        add_error :strong_attitudes, STRONG_ATTITUDES_COUNT
      end
    end
    
    def correct_number_of_weak_attitudes
      if weak_attitudes.count != WEAK_ATTITUDES_COUNT
        add_error :weak_attitudes, WEAK_ATTITUDES_COUNT
      end
    end
    
    def transition_state(back = false)
      index = ASSESSMENT_STATES.index(self.aasm_state.to_sym)
      if back
        aasm_state = ASSESSMENT_STATES[index - 1]
      else
        aasm_state = ASSESSMENT_STATES[index + 1]
      end
      update_column(:aasm_state, aasm_state) unless aasm_state.nil?
    end
    
    def add_error(attribute, count)
      errors.add attribute, error_message(attribute, count)
    end
    
    def error_message(attribute, count)
      I18n.t("activerecord.errors.models.assessment.attributes.#{attribute}.count", count: count)
    end

end
