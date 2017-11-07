class Assessment < ApplicationRecord
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
  
  def available_skills
    Skill.where.not(id: skill_answers.map { |s| s.skill_id } )
  end
  
  def available_attitudes
    Attitude.where.not(id: attitude_answers.map { |s| s.attitude_id } )
  end

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
    
    event :add_user_details do
      transitions from: :weak_attitudes_added, to: :complete
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
    
    def transition_state
      job = self.aasm.events.map(&:name).first
      self.send(job) unless job.nil?
    end

end
