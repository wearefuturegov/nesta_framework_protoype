class AddAsessmentIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :assessment_id, :integer
  end
end
