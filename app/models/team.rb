class Team < ApplicationRecord
  has_many :users
  
  accepts_nested_attributes_for :users
  
  def users_attributes=(users_attrs)
    users_attrs.each do |user|
      self.users << if user[:id]
        u = User.find(user[:id])
        u.update_column(:team_id, self.id)
        u
      else
        User.create(user.merge(team_id: id))
      end
    end
  end
end
