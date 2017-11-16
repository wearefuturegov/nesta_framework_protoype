class AddBehaviours < ActiveRecord::Migration[5.1]
  def change
    create_table :behaviours do |t|
      t.text :description
      t.references :skill

      t.timestamps
    end
  end
end
