class CreateTeas < ActiveRecord::Migration[7.1]
  def change
    create_table :teas do |t|
      t.string :name
      t.string :description
      t.string :brew_time
      t.integer :temperature

      t.timestamps
    end
  end
end
