class AddFullTextSearchToTeaSubscriptions < ActiveRecord::Migration[7.1]
  def change
    add_column :tea_subscriptions, :search_vector, :tsvector

    add_index :tea_subscriptions, :search_vector, using: :gin
  end
end
