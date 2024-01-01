class AddEditedToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :edited, :boolean, null: false, default: false
  end
end
