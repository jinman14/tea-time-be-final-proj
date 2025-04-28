class CreateTeaSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :tea_subscriptions do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :tea, null: false, foreign_key: true
      t.string :frequency
      t.integer :status

      t.timestamps
    end
  end
end
