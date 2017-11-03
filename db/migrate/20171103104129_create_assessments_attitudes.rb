class CreateAssessmentsAttitudes < ActiveRecord::Migration[5.1]
  def change
    create_table :assessments_attitudes, id: false do |t|
      t.integer :assessment_id
      t.integer :attitude_id
    end
  end
end
