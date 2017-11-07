class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :organisation_type
      t.string :position
      t.string :location

      t.timestamps
    end
  end
end
