class Team < ApplicationRecord
  has_many :users
  
  accepts_nested_attributes_for :users
  after_create :email_users
  
  def users_attributes=(users_attrs)
    users = users_attrs.values
    users.delete_if { |attrs| attrs['id'].blank? && attrs['email'].blank? }
    users.each do |user|
      self.users << if user[:id].present?
        u = User.find(user[:id])
        u.update_column(:team_id, self.id)
        u
      else
        User.create(user.merge(team_id: id))
      end
    end
  end
  
  def assessments
    users_and_assessments.map { |u| u.assessment }.compact
  end
  
  def users_without_assessments
    users_and_assessments.where(assessments: { id: nil }).uniq
  end
  
  def users_and_assessments
    users.left_outer_joins(:assessment)
  end
  
  private
  
    def email_users
      users_without_assessments.each do |user|
        SendEmail.enqueue('UserMailer', :assessment_invite, user.id)
      end
    end
    
end
