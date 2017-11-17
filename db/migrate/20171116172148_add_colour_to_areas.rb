class AddColourToAreas < ActiveRecord::Migration[5.1]
  def change
    add_column :areas, :colour, :string
  end
end
