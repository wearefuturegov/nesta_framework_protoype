class CreateAssessmentAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :assessment_answers do |t|
      t.integer :assessment_id
      t.integer :skill_id
      t.integer :attitude_id
      t.string :answer_type

      t.timestamps
    end
  end
end
