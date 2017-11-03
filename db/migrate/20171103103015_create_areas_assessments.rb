class CreateAreasAssessments < ActiveRecord::Migration[5.1]
  def change
    create_table :areas_assessments, id: false do |t|
      t.integer :assessment_id
      t.integer :area_id
    end
  end
end
