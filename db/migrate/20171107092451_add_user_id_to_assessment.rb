class AddUserIdToAssessment < ActiveRecord::Migration[5.1]
  def change
    add_column :assessments, :user_id, :integer
  end
end
