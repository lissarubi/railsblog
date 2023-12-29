class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.text :title, null: false
      t.text :body, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :views, null:false, :default => 0

      t.timestamps
    end
  end
end
