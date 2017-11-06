class AddAasmStateToAssessments < ActiveRecord::Migration[5.1]
  def change
    add_column :assessments, :aasm_state, :string
  end
end
